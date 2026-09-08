//
//  TodaysQuestCard.swift
//  SlipEasy
//
//  A single fixed daily quest matching Decrave's Home "Today's quest"
//  module. Unlike the HTML prototype (where "Accept" just relabels the
//  button), tapping Accept here launches the real SOS flow — the same
//  fullScreenCover the floating "Decrave it" button opens (see
//  MainFlowView) — so the quest leads to an actual practice session
//  instead of a no-op tap.
//

import SwiftUI

struct TodaysQuestCard: View {
    var onAccept: () -> Void

    @AppStorage("todaysQuestAcceptedDate") private var acceptedDateString = ""

    private var isAcceptedToday: Bool {
        acceptedDateString == Self.todayKey
    }

    // A plain "yyyy-MM-dd" string is enough to key "already accepted
    // today" and reset itself the next calendar day — no need for a
    // stored Date or a new SwiftData model just for this.
    private static var todayKey: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.Home.questEyebrow)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(Color.violet)

            Text(Strings.Home.questTitle)
                .font(.headline)
                .foregroundStyle(.primary)

            Text(Strings.Home.questBody)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                Text(Strings.Home.questMomentumTag(InsightsEngine.momentumGainPerBeaten))
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(Color.accentColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.accentColor.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))

                Spacer()

                Button(action: accept) {
                    Text(isAcceptedToday ? Strings.Home.questAccepted : Strings.Home.questAccept)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(isAcceptedToday ? .secondary : .primary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Color.cardFillElevated)
                        .clipShape(Capsule())
                }
                .buttonStyle(.hapticPlain)
                .disabled(isAcceptedToday)
            }
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .cardStyle()
    }

    private func accept() {
        acceptedDateString = Self.todayKey
        onAccept()
    }
}

#Preview {
    VStack(spacing: 12) {
        TodaysQuestCard(onAccept: {})
    }
    .padding()
    .background(Color.appBackground)
}
