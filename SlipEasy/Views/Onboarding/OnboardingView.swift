//
//  OnboardingView.swift
//  SlipEasy
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @AppStorage("onboardingStatus") private var onboardingStatus: String = ""
    @AppStorage("cigsPerDay") private var cigsPerDayStored: Int = 10
    @AppStorage("pricePerPack") private var pricePerPackStored: Double = 8.5

    @State private var page = 0
    @State private var selectedStatus: String?
    @State private var cigsPerDay: Double = 10
    @State private var pricePerPack: Double = 8.5

    var body: some View {
        // Custom dots pinned below the TabView instead of the system page
        // indicator, which rendered on top of each page's bottom button
        // with low contrast.
        VStack(spacing: 0) {
            TabView(selection: $page) {
                OnboardingIntroPage(onContinue: { page = 1 })
                    .tag(0)

                OnboardingStatusPage(selectedStatus: $selectedStatus, onSelect: { page = 2 })
                    .tag(1)

                OnboardingCigsPage(cigsPerDay: $cigsPerDay, onDone: { page = 3 })
                    .tag(2)

                OnboardingPricePage(pricePerPack: $pricePerPack, onDone: { page = 4 })
                    .tag(3)

                OnboardingAnalyticsPage(onChoose: complete)
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.default, value: page)

            OnboardingPageIndicator(current: page, total: 5)
                .padding(.bottom, 12)
        }
        .background(Color.appBackground.ignoresSafeArea())
    }

    private func complete(analyticsConsent: Bool) {
        onboardingStatus = selectedStatus ?? "B"
        cigsPerDayStored = Int(cigsPerDay)
        pricePerPackStored = pricePerPack
        Analytics.setConsent(analyticsConsent)
        Analytics.trackOnboardingCompleted(status: onboardingStatus, cigsPerDay: cigsPerDayStored)
        hasCompletedOnboarding = true
    }
}

#Preview {
    OnboardingView(hasCompletedOnboarding: .constant(false))
}
