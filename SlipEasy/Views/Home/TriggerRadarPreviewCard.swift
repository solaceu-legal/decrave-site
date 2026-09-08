//
//  TriggerRadarPreviewCard.swift
//  SlipEasy
//
//  Free teaser matching Decrave's Home radar card — it's not blurred or
//  locked (that's reserved for the deeper detail in Insights), just
//  branded as a Pro feature. Tapping it hands off to the Insights tab.
//

import SwiftUI

struct TriggerRadarPreviewCard: View {
    let prediction: InsightsEngine.PredictedWindow?
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(Strings.Home.triggerRadarEyebrow)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.sky)
                    Spacer()
                    Text(Strings.Home.proBadge)
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color.gold.opacity(0.16))
                        .foregroundStyle(Color.gold)
                        .clipShape(Capsule())
                }

                if let prediction {
                    Text(Strings.Home.triggerRadarWindowLabel(weekday: prediction.weekdayName, hour: prediction.formattedHour))
                        .font(.headline)
                        .foregroundStyle(Color.sky)
                    Text(subtitle(for: prediction))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                } else {
                    Text(Strings.Home.triggerRadarPlaceholder)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }

                // Decorative only — the whole card is already the tap
                // target (onTap above), this just visually echoes
                // Decrave's explicit "Preview radar" button.
                HStack {
                    Spacer()
                    Text(Strings.Home.triggerRadarPreviewCTA)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Color.cardFillElevated)
                        .clipShape(Capsule())
                }
                .padding(.top, 4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .cardStyle()
        }
        .buttonStyle(.hapticPlain)
    }

    private func subtitle(for window: InsightsEngine.PredictedWindow) -> String {
        if let trigger = window.trigger {
            return Strings.Home.triggerRadarTriggerNote(trigger: trigger.label.lowercased(), occurrences: window.occurrences)
        }
        return Strings.Home.triggerRadarOccurrenceNote(occurrences: window.occurrences)
    }
}

#Preview {
    VStack(spacing: 12) {
        TriggerRadarPreviewCard(prediction: nil, onTap: {})
        TriggerRadarPreviewCard(
            prediction: .init(weekday: 3, hour: 15, trigger: .coffee, occurrences: 4),
            onTap: {}
        )
    }
    .padding()
    .background(Color.appBackground)
}
