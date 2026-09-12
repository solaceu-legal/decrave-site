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

    private static let proProductIDs = Set(ProProduct.allCases.map(\.rawValue))

    private(set) var products: [Product] = []
    private(set) var purchasedProductIDs: Set<String> = []
    private(set) var isLoadingProducts = false

    // A subscription active within its period or a lifetime purchase both
    // show up here — Transaction.currentEntitlements already applies the
    // right expiry semantics for each, so there's no separate "is this a
    // subscription vs a one-time purchase" branch needed.
    var isPro: Bool { !purchasedProductIDs.isDisjoint(with: Self.proProductIDs) }

    private var transactionListenerTask: Task<Void, Never>?

    init(startTransactionListener: Bool = true, loadImmediately: Bool = true) {
        if startTransactionListener {
            transactionListenerTask = listenForTransactions()
        }
        if loadImmediately {
            Task {
                await self.loadProducts()
                await self.refreshPurchasedProducts()
            }
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
            // Apply the verified transaction immediately. A later lifecycle
            // refresh reconciles the complete entitlement set and removes
            // anything that has expired or been refunded.
            purchasedProductIDs.insert(transaction.productID)
            await transaction.finish()
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

    /// Rebuilds the entitlement cache from Apple's authoritative current
    /// state. This must replace the cache: expired and refunded products are
    /// intentionally absent from `currentEntitlements` and therefore cannot
    /// be removed correctly by an additive merge.
    func refreshPurchasedProducts() async {
        var active: Set<String> = []
        for await result in Transaction.currentEntitlements {
            guard let transaction = try? checkVerified(result) else { continue }
            guard Self.proProductIDs.contains(transaction.productID) else { continue }
            if transaction.revocationDate == nil,
               transaction.expirationDate.map({ $0 > Date() }) ?? true {
                active.insert(transaction.productID)
            }
        }
        purchasedProductIDs = active
    }

    // Non-detached: inherits this class's MainActor isolation, so calls to
    // the other instance methods below don't need to hop actors explicitly.
    private func listenForTransactions() -> Task<Void, Never> {
        Task {
            for await result in Transaction.updates {
                guard let transaction = try? self.checkVerified(result) else { continue }
                guard Self.proProductIDs.contains(transaction.productID) else {
                    await transaction.finish()
                    continue
                }
                if transaction.revocationDate != nil ||
                    transaction.expirationDate.map({ $0 <= Date() }) == true {
                    self.purchasedProductIDs.remove(transaction.productID)
                } else {
                    self.purchasedProductIDs.insert(transaction.productID)
                }
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
