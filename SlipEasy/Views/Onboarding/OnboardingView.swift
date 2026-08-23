//
//  OnboardingView.swift
//  SlipEasy
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @AppStorage("onboardingStatus") private var onboardingStatus: String = ""
    @AppStorage("cigsPerDay") private var cigsPerDayStored: Int = 10

    @State private var page = 0
    @State private var selectedStatus: String?
    @State private var cigsPerDay: Double = 10

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

                OnboardingCigsPage(cigsPerDay: $cigsPerDay, onDone: complete)
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.default, value: page)

            OnboardingPageIndicator(current: page, total: 3)
                .padding(.bottom, 12)
        }
    }

    private func complete() {
        onboardingStatus = selectedStatus ?? "B"
        cigsPerDayStored = Int(cigsPerDay)
        Analytics.trackOnboardingCompleted(status: onboardingStatus, cigsPerDay: cigsPerDayStored)
        hasCompletedOnboarding = true
    }
}

#Preview {
    OnboardingView(hasCompletedOnboarding: .constant(false))
}
