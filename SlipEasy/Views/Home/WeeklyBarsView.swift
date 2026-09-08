//
//  WeeklyBarsView.swift
//  SlipEasy
//

import SwiftUI

/// Non-interactive last-7-days trend. Not tappable, not a full chart —
/// full charting is explicitly out of scope for v0.1. Each bar carries
/// its own weekday initial and count so the chart reads on its own,
/// without relying on the card's caption to explain what's being
/// measured.
struct WeeklyBarsView: View {
    let logs: [CravingLog]

    private struct DayCount: Identifiable {
        let id: Int
        let weekdayLabel: String
        let count: Int
    }

    private var dailyCounts: [DayCount] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEEE") // narrow weekday initial: M, T, W...
        return (0..<7).reversed().enumerated().compactMap { index, offset in
            guard let day = calendar.date(byAdding: .day, value: -offset, to: today) else { return nil }
            let count = logs.filter { calendar.isDate($0.timestamp, inSameDayAs: day) }.count
            return DayCount(id: index, weekdayLabel: formatter.string(from: day), count: count)
        }
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            ForEach(dailyCounts) { day in
                VStack(spacing: 6) {
                    Text("\(day.count)")
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .foregroundStyle(day.count > 0 ? Color.primary : Color.secondary)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(day.count == 0 ? AnyShapeStyle(Color.white.opacity(0.12)) : AnyShapeStyle(LinearGradient.brand))
                        .frame(height: barHeight(for: day.count))
                    Text(day.weekdayLabel)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 90, alignment: .bottom)
    }

    private func barHeight(for count: Int) -> CGFloat {
        let minHeight: CGFloat = 4
        let maxHeight: CGFloat = 50
        guard count > 0 else { return minHeight }
        let maxCount = max(dailyCounts.map(\.count).max() ?? 1, 1)
        return minHeight + (CGFloat(count) / CGFloat(maxCount)) * (maxHeight - minHeight)
    }
}

#Preview {
    WeeklyBarsView(logs: [])
        .padding()
        .background(Color.appBackground)
}
