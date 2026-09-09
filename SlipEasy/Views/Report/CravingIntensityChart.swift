//
//  CravingIntensityChart.swift
//  SlipEasy
//
//  Unlike WeeklyBarsView's rolling 7-day window, this charts a fixed
//  Monday-through-Sunday calendar week (regardless of the device
//  locale's own firstWeekday) — average intensity (1...5, from
//  CravingLog.intensity) instead of a count. The day(s) tied for the
//  week's highest average are highlighted, mirroring Decrave's "hot"
//  bar treatment. Takes the unfiltered log set (not a pre-windowed
//  one) since it does its own date bucketing, the same way
//  WeeklyBarsView takes all of Home's beatenLogs.
//

import SwiftUI

struct CravingIntensityChart: View {
    let logs: [CravingLog]

    private struct DayIntensity: Identifiable {
        let id: Int
        let weekdayLabel: String
        let averageIntensity: Double // 0 when no logs that day
    }

    private var dailyIntensities: [DayIntensity] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        // .weekday is always 1 = Sunday ... 7 = Saturday in the Gregorian
        // calendar, independent of the locale's firstWeekday setting —
        // this maps it to "days since Monday" so the week starts on
        // Monday everywhere, not just in locales where that's the default.
        let weekday = calendar.component(.weekday, from: today)
        let daysSinceMonday = (weekday + 5) % 7
        guard let monday = calendar.date(byAdding: .day, value: -daysSinceMonday, to: today) else { return [] }

        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEEE") // narrow weekday initial: M, T, W...
        return (0..<7).compactMap { offset in
            guard let day = calendar.date(byAdding: .day, value: offset, to: monday) else { return nil }
            let dayLogs = logs.filter { calendar.isDate($0.timestamp, inSameDayAs: day) }
            let average = dayLogs.isEmpty ? 0 : Double(dayLogs.reduce(0) { $0 + $1.intensity }) / Double(dayLogs.count)
            return DayIntensity(id: offset, weekdayLabel: formatter.string(from: day), averageIntensity: average)
        }
    }

    private var peakIntensity: Double {
        dailyIntensities.map(\.averageIntensity).max() ?? 0
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            ForEach(dailyIntensities) { day in
                VStack(spacing: 6) {
                    Text(valueLabel(for: day.averageIntensity))
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .foregroundStyle(day.averageIntensity > 0 ? Color.primary : Color.secondary)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(isPeak(day) ? AnyShapeStyle(LinearGradient.brand) : AnyShapeStyle(Color.white.opacity(0.12)))
                        .frame(height: barHeight(for: day.averageIntensity))
                    Text(day.weekdayLabel)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 90, alignment: .bottom)
    }

    private func isPeak(_ day: DayIntensity) -> Bool {
        peakIntensity > 0 && day.averageIntensity == peakIntensity
    }

    // Whole logs are 1...5, but a day's average of several can land on a
    // fraction (two logs of 3 and 4 average to 3.5) — one decimal place
    // shows that instead of silently rounding it away. A plain "0" (not
    // "0.0") reads more clearly as "no logs" rather than "measured zero,"
    // since intensity itself is never actually 0.
    private func valueLabel(for intensity: Double) -> String {
        guard intensity > 0 else { return "0" }
        return String(format: "%.1f", intensity)
    }

    private func barHeight(for intensity: Double) -> CGFloat {
        let minHeight: CGFloat = 4
        let maxHeight: CGFloat = 50
        guard intensity > 0 else { return minHeight }
        let fraction = (intensity - 1) / 4 // intensity is 1...5, same scale as LogView's slider
        return minHeight + CGFloat(max(0, min(1, fraction))) * (maxHeight - minHeight)
    }
}

#Preview {
    CravingIntensityChart(logs: [])
        .padding()
        .background(Color.appBackground)
}
