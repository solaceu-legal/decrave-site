//
//  WeeklyBarsView.swift
//  SlipEasy
//

import SwiftUI

/// Non-interactive last-7-days trend. Not tappable, not a full chart —
/// full charting is explicitly out of scope for v0.1.
struct WeeklyBarsView: View {
    let logs: [CravingLog]

    private var dailyCounts: [Int] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (0..<7).reversed().compactMap { offset in
            guard let day = calendar.date(byAdding: .day, value: -offset, to: today) else { return 0 }
            return logs.filter { calendar.isDate($0.timestamp, inSameDayAs: day) }.count
        }
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            ForEach(Array(dailyCounts.enumerated()), id: \.offset) { _, count in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.accentColor.opacity(count == 0 ? 0.2 : 0.8))
                    .frame(width: 16, height: barHeight(for: count))
            }
        }
        .frame(height: 60, alignment: .bottom)
    }

    private func barHeight(for count: Int) -> CGFloat {
        let minHeight: CGFloat = 4
        let maxHeight: CGFloat = 60
        guard count > 0 else { return minHeight }
        let maxCount = max(dailyCounts.max() ?? 1, 1)
        return minHeight + (CGFloat(count) / CGFloat(maxCount)) * (maxHeight - minHeight)
    }
}

#Preview {
    WeeklyBarsView(logs: [])
}
