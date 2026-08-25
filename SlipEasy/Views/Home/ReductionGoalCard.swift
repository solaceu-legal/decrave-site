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
        if let target = plan?.targetCigsPerDay {
            // Neutral color and wording regardless of whether today's
            // count is over target — no red, no "over budget" language.
            Text(Strings.ReductionGoal.todayProgress(smoked: todaySmokedCount, target: target))
                .font(.subheadline)
                .foregroundStyle(.secondary)
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
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.hapticPlain)
        }
    }
}

#Preview {
    ReductionGoalCard(plan: nil, smokedLogs: [], onSetGoal: {})
}
