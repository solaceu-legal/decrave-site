//
//  InsightCard.swift
//  SlipEasy
//

import SwiftUI

struct InsightCard: View {
    let icon: String
    let title: String
    let message: String
    var suggestion: String? = nil

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(Color.accentColor)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                if let suggestion {
                    Text(suggestion)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}

#Preview {
    VStack(spacing: 12) {
        InsightCard(
            icon: "lightbulb.fill",
            title: Strings.Insights.triggerPatternTitle,
            message: Strings.Insights.triggerPatternBody(trigger: .meal, count: 4),
            suggestion: Strings.Insights.triggerSuggestion(.meal)
        )
        InsightCard(
            icon: "checkmark.seal.fill",
            title: Strings.Insights.toolEffectivenessTitle,
            message: Strings.Insights.toolEffectivenessBody(attemptCount: 5, beatenCount: 4)
        )
    }
    .padding()
}
