//
//  OnboardingIntroPage.swift
//  SlipEasy
//

import SwiftUI

struct OnboardingIntroPage: View {
    let onContinue: () -> Void

    var body: some View {
        // ScrollView + minHeight: centered at normal text sizes, scrolls
        // instead of truncating at max Dynamic Type (see InterventionEndView).
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 0)

                    VStack(spacing: 12) {
                        Text(Strings.Onboarding.introTitle)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)

                        Text(Strings.Onboarding.introSubtitle)
                            .font(.title3)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 32)

                    Spacer(minLength: 0)

                    Button(action: onContinue) {
                        Text(Strings.Onboarding.introContinue)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.hapticProminent)
                    .controlSize(.large)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 24)
                }
                .frame(minHeight: geometry.size.height)
            }
        }
    }
}

#Preview {
    OnboardingIntroPage(onContinue: {})
}
