//
//  TopTriggersRows.swift
//  SlipEasy
//
//  Row layout matching Decrave's Top triggers card — icon + label,
//  progress track, percentage — one row per trigger that showed up
//  this week (see InsightsEngine.triggerBreakdown).
//

import SwiftUI

struct TopTriggersRows: View {
    let breakdown: [InsightsEngine.TriggerBreakdown]

    var body: some View {
        if breakdown.isEmpty {
            Text(Strings.Report.notEnoughData)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        } else {
            VStack(spacing: 10) {
                ForEach(breakdown) { item in
                    row(for: item)
                }
            }
        }
    }

    private func row(for item: InsightsEngine.TriggerBreakdown) -> some View {
        HStack(spacing: 12) {
            // A fixed-width icon slot, not Label's own intrinsic sizing —
            // SF Symbols vary in glyph width (wineglass vs. fork.knife vs.
            // zzz), so without it the label text starts at a different x
            // per row instead of lining up in a column.
            HStack(spacing: 8) {
                Image(systemName: item.trigger.iconName)
                    .font(.subheadline)
                    .frame(width: 20)
                Text(item.trigger.label)
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)
            }
            .frame(width: 110, alignment: .leading)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white.opacity(0.07))
                    RoundedRectangle(cornerRadius: 4)
                        .fill(LinearGradient.brand)
                        .frame(width: geometry.size.width * item.percentage)
                }
            }
            .frame(height: 7)

            Text(Strings.Report.triggerPercentage(Int((item.percentage * 100).rounded())))
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
                .frame(width: 36, alignment: .trailing)
        }
    }
}

#Preview {
    TopTriggersRows(breakdown: [
        .init(trigger: .coffee, count: 5, percentage: 0.45),
        .init(trigger: .stress, count: 3, percentage: 0.27),
        .init(trigger: .boredom, count: 2, percentage: 0.18)
    ])
    .padding()
    .background(Color.appBackground)
}
