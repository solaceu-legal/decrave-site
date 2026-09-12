import XCTest
import StoreKit
import StoreKitTest
@testable import SlipEasy

@MainActor
final class StoreManagerTests: XCTestCase {
    private var session: SKTestSession!

    override func setUpWithError() throws {
        session = try SKTestSession(configurationFileNamed: "Configuration")
        session.disableDialogs = true
        session.clearTransactions()
    }

    override func tearDown() {
        session.clearTransactions()
        session = nil
        super.tearDown()
    }

    func testLoadsEveryConfiguredProduct() async {
        let manager = StoreManager(startTransactionListener: false, loadImmediately: false)
        await manager.loadProducts()

        XCTAssertEqual(Set(manager.products.map(\.id)), Set(ProProduct.allCases.map(\.rawValue)))
    }

    func testLifetimePurchaseUnlocksAndRestores() async throws {
        _ = try await session.buyProduct(identifier: ProProduct.lifetime.rawValue)

        let manager = StoreManager(startTransactionListener: false, loadImmediately: false)
        let restored = await waitForEntitlement(
            ProProduct.lifetime.rawValue,
            present: true,
            in: manager
        )

        XCTAssertTrue(restored)
        XCTAssertTrue(manager.isPro)
        XCTAssertTrue(manager.purchasedProductIDs.contains(ProProduct.lifetime.rawValue))
    }

    func testYearlyTrialConfigurationAndPurchaseUnlocks() async throws {
        let manager = StoreManager(startTransactionListener: false, loadImmediately: false)
        await manager.loadProducts()

        let yearly = try XCTUnwrap(manager.products.first {
            $0.id == ProProduct.yearly.rawValue
        })
        let offer = try XCTUnwrap(yearly.subscription?.introductoryOffer)
        XCTAssertEqual(offer.paymentMode, .freeTrial)
        XCTAssertEqual(offer.period.unit, .day)
        XCTAssertEqual(offer.period.value, 7)

        _ = try await session.buyProduct(identifier: yearly.id)
        let activated = await waitForEntitlement(yearly.id, present: true, in: manager)

        XCTAssertTrue(activated)
        XCTAssertTrue(manager.isPro)
    }

    func testExpiredSubscriptionIsRemovedByRefresh() async throws {
        _ = try await session.buyProduct(identifier: ProProduct.monthly.rawValue)

        let manager = StoreManager(startTransactionListener: false, loadImmediately: false)
        let activated = await waitForEntitlement(
            ProProduct.monthly.rawValue,
            present: true,
            in: manager
        )
        XCTAssertTrue(activated)

        try session.expireSubscription(productIdentifier: ProProduct.monthly.rawValue)
        let expired = await waitForEntitlement(
            ProProduct.monthly.rawValue,
            present: false,
            in: manager
        )
        XCTAssertTrue(expired)

        XCTAssertFalse(manager.isPro)
        XCTAssertFalse(manager.purchasedProductIDs.contains(ProProduct.monthly.rawValue))
    }

    private func waitForEntitlement(
        _ productID: String,
        present: Bool,
        in manager: StoreManager
    ) async -> Bool {
        // StoreKit's test daemon publishes current entitlements
        // asynchronously. Poll briefly so this verifies app behavior rather
        // than racing the daemon immediately after a simulated transaction.
        for _ in 0..<30 {
            await manager.refreshPurchasedProducts()
            if manager.purchasedProductIDs.contains(productID) == present {
                return true
            }
            try? await Task.sleep(for: .milliseconds(200))
        }
        return false
    }
}
