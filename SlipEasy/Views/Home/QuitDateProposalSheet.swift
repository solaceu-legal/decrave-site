//
//  QuitDateProposalSheet.swift
//  SlipEasy
//

import SwiftUI

/// Shown once a 14-day streak is detected. Swiping the sheet away is not
/// treated as a decline — only tapping "Not now" starts the 2-week
/// cooldown, same respect-the-exit principle as the intervention screen.
struct QuitDateProposalSheet: View {
    let onAccept: () -> Void
    let onDecline: () -> Void

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 0)

                    VStack(spacing: 12) {
                        Text(Strings.ReductionGoal.proposalTitle)
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)

                        Text(Strings.ReductionGoal.proposalBody)
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 32)

                    Spacer(minLength: 0)

                    VStack(spacing: 12) {
                        Button(action: onAccept) {
                            Text(Strings.ReductionGoal.proposalAccept)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.hapticProminent)
                        .controlSize(.large)

                        Button(action: onDecline) {
                            Text(Strings.ReductionGoal.proposalDecline)
                                .foregroundStyle(.secondary)
                        }
                        .buttonStyle(.hapticPlain)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                }
                .frame(minHeight: geometry.size.height)
            }
        }
        .background(Color.appBackground.ignoresSafeArea())
    }
}

#Preview {
    QuitDateProposalSheet(onAccept: {}, onDecline: {})
}
