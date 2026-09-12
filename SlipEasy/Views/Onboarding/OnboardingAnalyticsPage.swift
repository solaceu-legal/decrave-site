//
//  OnboardingAnalyticsPage.swift
//  SlipEasy
//

import SwiftUI

struct OnboardingAnalyticsPage: View {
    let onChoose: (Bool) -> Void

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 0)

                    Image(systemName: "chart.bar.xaxis")
                        .font(.largeTitle)
                        .foregroundStyle(Color.accentColor)

                    VStack(spacing: 12) {
                        Text(Strings.Onboarding.analyticsTitle)
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)

                        Text(Strings.Onboarding.analyticsBody)
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 32)

                    Spacer(minLength: 0)

                    VStack(spacing: 14) {
                        Button {
                            onChoose(true)
                        } label: {
                            Text(Strings.Onboarding.analyticsAllow)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.hapticProminent)
                        .controlSize(.large)

                        Button(Strings.Onboarding.analyticsDecline) {
                            onChoose(false)
                        }
                        .buttonStyle(.hapticPlain)
                        .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 24)
                }
                .frame(minHeight: geometry.size.height)
            }
        }
    }
}

#Preview {
    OnboardingAnalyticsPage(onChoose: { _ in })
}
