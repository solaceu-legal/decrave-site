//
//  ReductionGoalCard.swift
//  SlipEasy
//

import SwiftUI

struct ReductionGoalCard: View {
    let plan: ReductionPlan?
    let smokedLogs: [CravingLog]
    let onSetGoal: () -> Void

    private var todaySmokedCount: Int {
        let calendar = Calendar.current
        return smokedLogs.filter { calendar.isDateInToday($0.timestamp) }.count
    }

    var body: some View {
        // Both states render as the same full-width card shape as every
        // other Home section — this used to be a hugging-width pill in
        // the "no goal set" state and a bare, uncontained line of text in
        // the "goal set" state, which read as misaligned next to the
        // hero/weekly cards above and below it.
        if let target = plan?.targetCigsPerDay {
            // Neutral color and wording regardless of whether today's
            // count is over target — no red, no "over budget" language.
            Text(Strings.ReductionGoal.todayProgress(smoked: todaySmokedCount, target: target))
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .cardStyle()
        } else {
            Button(action: onSetGoal) {
                VStack(spacing: 4) {
                    Text(Strings.ReductionGoal.cardTitlePrompt)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primary)
                    Text(Strings.ReductionGoal.cardSubtitlePrompt)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .cardStyle()
            }
            .buttonStyle(.hapticPlain)
        }
    }
}

#Preview {
    ReductionGoalCard(plan: nil, smokedLogs: [], onSetGoal: {})
}
