//
//  OnboardingPricePage.swift
//  SlipEasy
//

import SwiftUI

struct OnboardingPricePage: View {
    @Binding var pricePerPack: Double
    let onDone: () -> Void

    @ScaledMetric(relativeTo: .largeTitle) private var numberSize: CGFloat = 48

    private var formattedPrice: String {
        InsightsEngine.formattedMoney(pricePerPack)
    }

    var body: some View {
        // Same centered ScrollView/GeometryReader pattern as
        // OnboardingCigsPage — this feeds the same money-saved math Home
        // and the SOS victory screen already use.
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 0)

                    Text(Strings.Onboarding.priceQuestion)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)

                    Text(formattedPrice)
                        .font(.system(size: numberSize, weight: .bold, design: .rounded))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)

                    Slider(value: $pricePerPack, in: 3...20, step: 0.5)
                        .padding(.horizontal, 32)

                    Text(Strings.Onboarding.priceCaption)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)

                    Spacer(minLength: 0)

                    Button(action: onDone) {
                        Text(Strings.Onboarding.priceDone)
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
    OnboardingPricePage(pricePerPack: .constant(8.5), onDone: {})
}
