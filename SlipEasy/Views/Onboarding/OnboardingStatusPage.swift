//
//  OnboardingStatusPage.swift
//  SlipEasy
//

import SwiftUI

struct OnboardingStatusPage: View {
    @Binding var selectedStatus: String?
    let onSelect: () -> Void

    private let options: [(code: String, label: String)] = [
        ("A", Strings.Onboarding.statusA),
        ("B", Strings.Onboarding.statusB),
        ("C", Strings.Onboarding.statusC)
    ]

    var body: some View {
        // ScrollView + minHeight keeps this centered at normal text sizes
        // but lets it scroll instead of truncating an option at max
        // Dynamic Type (the three choices must stay equally readable).
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 0)

                    Text(Strings.Onboarding.statusQuestion)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)

                    VStack(spacing: 12) {
                        ForEach(options, id: \.code) { option in
                            Button {
                                selectedStatus = option.code
                                onSelect()
                            } label: {
                                Text(option.label)
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .cardStyle()
                            }
                            .buttonStyle(.plain)
                            .foregroundStyle(Color.primary)
                        }
                    }
                    .padding(.horizontal, 24)

                    Spacer(minLength: 0)
                }
                .frame(minHeight: geometry.size.height)
            }
        }
        .sensoryFeedback(.selection, trigger: selectedStatus)
    }
}

#Preview {
    OnboardingStatusPage(selectedStatus: .constant(nil), onSelect: {})
}
