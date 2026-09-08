//
//  PaywallView.swift
//  SlipEasy
//

import SwiftUI
import StoreKit

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @State private var storeManager = StoreManager.shared

    @State private var selectedProduct: Product?
    @State private var isYearlyTrialEligible: Bool?
    @State private var isPurchasing = false
    @State private var purchaseSucceeded = false
    @State private var errorAlert: ErrorAlert?

    private struct ErrorAlert: Identifiable {
        let id = UUID()
        let title: String
        let message: String
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 24) {
                        header

                        if purchaseSucceeded {
                            successView
                        } else if storeManager.isLoadingProducts && storeManager.products.isEmpty {
                            ProgressView()
                                .padding(.top, 60)
                        } else if storeManager.products.isEmpty {
                            loadErrorView
                        } else {
                            plansSection
                            ctaButton
                            restoreButton
                            legalLinks
                        }
                    }
                    .padding(24)
                    .frame(minHeight: geometry.size.height)
                }
            }
            .background(Color.appBackground.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(.hapticPlain)
                }
            }
        }
        .task {
            await storeManager.loadProducts()
            selectDefaultProductIfNeeded()
            await refreshTrialEligibility()
        }
        .onChange(of: storeManager.products) { _, _ in
            selectDefaultProductIfNeeded()
        }
        .alert(item: $errorAlert) { alert in
            Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .default(Text("OK")))
        }
    }

    private var header: some View {
        VStack(spacing: 8) {
            Text(Strings.Paywall.title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            Text(Strings.Paywall.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var successView: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 56))
                .foregroundStyle(.green)
            Text(Strings.Paywall.purchaseSuccessTitle)
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding(.top, 80)
    }

    private var loadErrorView: some View {
        VStack(spacing: 16) {
            Text(Strings.Paywall.loadErrorTitle)
                .font(.headline)
            Text(Strings.Paywall.loadErrorMessage)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Button(Strings.Paywall.retry) {
                Task { await storeManager.loadProducts() }
            }
            .buttonStyle(.hapticPlain)
        }
        .padding(.top, 60)
    }

    private var sortedProducts: [Product] {
        storeManager.products.sorted { a, b in
            let indexA = ProProduct.allCases.firstIndex { $0.rawValue == a.id } ?? 0
            let indexB = ProProduct.allCases.firstIndex { $0.rawValue == b.id } ?? 0
            return indexA < indexB
        }
    }

    private var plansSection: some View {
        VStack(spacing: 12) {
            ForEach(sortedProducts, id: \.id) { product in
                planCard(for: product)
            }
        }
    }

    private func planCard(for product: Product) -> some View {
        let isYearly = product.id == ProProduct.yearly.rawValue
        let isSelected = selectedProduct?.id == product.id

        return Button {
            selectedProduct = product
        } label: {
            Group {
                // Squeezing a name column + price column + icon into one row
                // collapses to one letter per line at accessibility text
                // sizes (HStack has no room left for either Text) — stack
                // everything vertically instead once type size crosses that
                // threshold.
                if dynamicTypeSize.isAccessibilitySize {
                    accessibilityCardContent(product: product, isYearly: isYearly, isSelected: isSelected)
                } else {
                    regularCardContent(product: product, isYearly: isYearly, isSelected: isSelected)
                }
            }
            .padding(isYearly ? 20 : 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.cardFill)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(isSelected ? Color.accentColor : Color.cardStroke, lineWidth: isSelected && isYearly ? 3 : (isSelected ? 2 : 1))
            )
        }
        .buttonStyle(.hapticPlain)
    }

    private func regularCardContent(product: Product, isYearly: Bool, isSelected: Bool) -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text(displayName(for: product))
                        .font(.headline)
                        .foregroundStyle(.primary)
                    if isYearly {
                        bestValueBadge
                    }
                }
                if isYearly, isYearlyTrialEligible == true, let days = trialDays(for: product) {
                    Text(Strings.Paywall.freeTrialLabel(days: days))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer(minLength: 12)
            VStack(alignment: .trailing, spacing: 2) {
                Text(product.displayPrice)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(periodLabel(for: product))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            selectionIndicator(isSelected: isSelected)
        }
    }

    private func accessibilityCardContent(product: Product, isYearly: Bool, isSelected: Bool) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Text(displayName(for: product))
                    .font(.headline)
                    .foregroundStyle(.primary)
                Spacer()
                selectionIndicator(isSelected: isSelected)
            }
            if isYearly {
                bestValueBadge
            }
            if isYearly, isYearlyTrialEligible == true, let days = trialDays(for: product) {
                Text(Strings.Paywall.freeTrialLabel(days: days))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Text("\(product.displayPrice) \(periodLabel(for: product))")
                .font(.headline)
                .foregroundStyle(.primary)
        }
    }

    private var bestValueBadge: some View {
        Text(Strings.Paywall.bestValueBadge)
            .font(.caption2)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(LinearGradient.brand)
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }

    private func selectionIndicator(isSelected: Bool) -> some View {
        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
            .foregroundStyle(isSelected ? Color.accentColor : Color.secondary)
            .font(.title3)
    }

    private var ctaButton: some View {
        Button {
            purchaseSelectedProduct()
        } label: {
            Group {
                if isPurchasing {
                    ProgressView()
                } else {
                    Text(ctaLabel)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.hapticProminent)
        .controlSize(.large)
        .disabled(selectedProduct == nil || isPurchasing)
    }

    private var ctaLabel: String {
        guard let selectedProduct else { return Strings.Paywall.continueCTA }
        if selectedProduct.id == ProProduct.yearly.rawValue, isYearlyTrialEligible == true {
            return Strings.Paywall.startTrialCTA
        }
        return Strings.Paywall.continueCTA
    }

    private var restoreButton: some View {
        Button {
            restorePurchases()
        } label: {
            Text(Strings.Paywall.restorePurchases)
        }
        .buttonStyle(.hapticPlain)
    }

    private var legalLinks: some View {
        HStack(spacing: 16) {
            if let url = URL(string: Strings.Settings.privacyPolicyURL) {
                Link(Strings.Settings.privacyPolicy, destination: url)
            }
            if let url = URL(string: Strings.Settings.termsOfUseURL) {
                Link(Strings.Settings.termsOfUse, destination: url)
            }
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }

    private func selectDefaultProductIfNeeded() {
        guard selectedProduct == nil else { return }
        selectedProduct = storeManager.products.first { $0.id == ProProduct.yearly.rawValue }
            ?? storeManager.products.first
    }

    private func refreshTrialEligibility() async {
        guard let yearlyProduct = storeManager.products.first(where: { $0.id == ProProduct.yearly.rawValue }),
              let subscription = yearlyProduct.subscription else {
            isYearlyTrialEligible = false
            return
        }
        isYearlyTrialEligible = await subscription.isEligibleForIntroOffer
    }

    private func purchaseSelectedProduct() {
        guard let selectedProduct else { return }
        isPurchasing = true
        Task {
            do {
                let success = try await storeManager.purchase(selectedProduct)
                isPurchasing = false
                if success {
                    purchaseSucceeded = true
                    try? await Task.sleep(for: .seconds(1.2))
                    dismiss()
                }
            } catch {
                isPurchasing = false
                errorAlert = ErrorAlert(title: Strings.Paywall.purchaseErrorTitle, message: Strings.Paywall.purchaseErrorMessage)
            }
        }
    }

    private func restorePurchases() {
        Task {
            do {
                try await storeManager.restorePurchases()
                if storeManager.isPro {
                    dismiss()
                } else {
                    errorAlert = ErrorAlert(title: Strings.Settings.restoreEmptyTitle, message: Strings.Settings.restoreEmptyMessage)
                }
            } catch {
                errorAlert = ErrorAlert(title: Strings.Settings.restoreErrorTitle, message: Strings.Settings.restoreErrorMessage)
            }
        }
    }

    private func displayName(for product: Product) -> String {
        product.displayName.isEmpty ? (ProProduct(rawValue: product.id)?.fallbackLabel ?? product.id) : product.displayName
    }

    private func periodLabel(for product: Product) -> String {
        guard let period = product.subscription?.subscriptionPeriod else {
            return Strings.Paywall.lifetimeLabel
        }
        switch period.unit {
        case .day: return period.value == 1 ? "/day" : "/\(period.value) days"
        case .week: return period.value == 1 ? "/week" : "/\(period.value) weeks"
        case .month: return period.value == 1 ? "/month" : "/\(period.value) months"
        case .year: return period.value == 1 ? "/year" : "/\(period.value) years"
        @unknown default: return ""
        }
    }

    private func trialDays(for product: Product) -> Int? {
        guard let offer = product.subscription?.introductoryOffer, offer.paymentMode == .freeTrial else { return nil }
        let period = offer.period
        switch period.unit {
        case .day: return period.value
        case .week: return period.value * 7
        case .month: return period.value * 30
        case .year: return period.value * 365
        @unknown default: return nil
        }
    }
}

#Preview {
    PaywallView()
}
