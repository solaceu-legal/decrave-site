//
//  OnboardingCigsPage.swift
//  SlipEasy
//

import SwiftUI

struct OnboardingCigsPage: View {
    @Binding var cigsPerDay: Double
    let onDone: () -> Void

    @ScaledMetric(relativeTo: .largeTitle) private var numberSize: CGFloat = 56

    var body: some View {
        // ScrollView + minHeight: centered at normal text sizes, scrolls
        // instead of truncating at max Dynamic Type (see InterventionEndView).
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 0)

                    Text(Strings.Onboarding.cigsQuestion)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)

                    Text("\(Int(cigsPerDay))")
                        .font(.system(size: numberSize, weight: .bold, design: .rounded))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)

                    Slider(value: $cigsPerDay, in: 1...40, step: 1)
                        .padding(.horizontal, 32)

                    Spacer(minLength: 0)

                    Button(action: onDone) {
                        Text(Strings.Onboarding.cigsDone)
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
    OnboardingCigsPage(cigsPerDay: .constant(10), onDone: {})
}
