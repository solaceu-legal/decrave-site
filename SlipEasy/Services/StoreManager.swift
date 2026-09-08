//
//  StoreManager.swift
//  SlipEasy
//

import Foundation
import StoreKit

@MainActor
@Observable
final class StoreManager {
    static let shared = StoreManager()

    private(set) var products: [Product] = []
    private(set) var purchasedProductIDs: Set<String> = []
    private(set) var isLoadingProducts = false

    // A subscription active within its period or a lifetime purchase both
    // show up here — Transaction.currentEntitlements already applies the
    // right expiry semantics for each, so there's no separate "is this a
    // subscription vs a one-time purchase" branch needed.
    var isPro: Bool { !purchasedProductIDs.isEmpty }

    private var transactionListenerTask: Task<Void, Never>?

    private init() {
        transactionListenerTask = listenForTransactions()
        Task {
            await self.loadProducts()
            await self.refreshPurchasedProducts()
        }
    }

    func loadProducts() async {
        isLoadingProducts = true
        defer { isLoadingProducts = false }
        do {
            products = try await Product.products(for: ProProduct.allCases.map(\.rawValue))
        } catch {
            products = []
        }
    }

    func purchase(_ product: Product) async throws -> Bool {
        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            // Update from the transaction already in hand immediately —
            // in the sandbox especially, re-querying
            // Transaction.currentEntitlements right after a purchase can
            // lag a few seconds behind, which left Pro content showing as
            // locked right after a successful purchase. The refresh below
            // still runs afterward to reconcile the full set (e.g. family
            // sharing), but it's additive now (see refreshPurchasedProducts)
            // so a still-lagging query can't wipe this back out.
            purchasedProductIDs.insert(transaction.productID)
            await transaction.finish()
            await refreshPurchasedProducts()
            return true
        case .userCancelled, .pending:
            return false
        @unknown default:
            return false
        }
    }

    func restorePurchases() async throws {
        try await AppStore.sync()
        await refreshPurchasedProducts()
    }

    // Additive (union newly-confirmed entitlements in, subtract only
    // ones the query positively confirms as revoked) rather than a
    // wholesale replace — a replace here is what let a lagging
    // Transaction.currentEntitlements query erase an entitlement
    // `purchase(_:)` had just added from the transaction it already
    // verified in hand.
    private func refreshPurchasedProducts() async {
        var active: Set<String> = []
        var revoked: Set<String> = []
        for await result in Transaction.currentEntitlements {
            guard let transaction = try? checkVerified(result) else { continue }
            if transaction.revocationDate == nil {
                active.insert(transaction.productID)
            } else {
                revoked.insert(transaction.productID)
            }
        }
        purchasedProductIDs.formUnion(active)
        purchasedProductIDs.subtract(revoked)
    }

    // Non-detached: inherits this class's MainActor isolation, so calls to
    // the other instance methods below don't need to hop actors explicitly.
    private func listenForTransactions() -> Task<Void, Never> {
        Task {
            for await result in Transaction.updates {
                guard let transaction = try? self.checkVerified(result) else { continue }
                await self.refreshPurchasedProducts()
                await transaction.finish()
            }
        }
    }

    private nonisolated func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
}

enum StoreError: Error {
    case failedVerification
}
