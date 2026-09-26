//
//  OnboardingPricePage.swift
//  SlipEasy
//

import SwiftUI

struct OnboardingPricePage: View {
    @Binding var pricePerPack: Double
    @Binding var currencyCode: String
    let onDone: () -> Void

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

                    PackPriceFields(pricePerPack: $pricePerPack, currencyCode: $currencyCode)
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
                    .disabled(!pricePerPack.isFinite || pricePerPack <= 0)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 24)
                }
                .frame(minHeight: geometry.size.height)
            }
        }
    }
}

#Preview {
    OnboardingPricePage(pricePerPack: .constant(8.5), currencyCode: .constant("USD"), onDone: {})
}
