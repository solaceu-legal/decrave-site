//
//  CravingIntensityChart.swift
//  SlipEasy
//
//  Same rolling-7-day bucketing as WeeklyBarsView (Home), but charts
//  average intensity (1...5, from CravingLog.intensity) instead of a
//  count. The day(s) tied for the week's highest average are
//  highlighted, mirroring Decrave's "hot" bar treatment.
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
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEEE") // narrow weekday initial: M, T, W...
        return (0..<7).reversed().enumerated().compactMap { index, offset in
            guard let day = calendar.date(byAdding: .day, value: -offset, to: today) else { return nil }
            let dayLogs = logs.filter { calendar.isDate($0.timestamp, inSameDayAs: day) }
            let average = dayLogs.isEmpty ? 0 : Double(dayLogs.reduce(0) { $0 + $1.intensity }) / Double(dayLogs.count)
            return DayIntensity(id: index, weekdayLabel: formatter.string(from: day), averageIntensity: average)
        }
    }

    private var peakIntensity: Double {
        dailyIntensities.map(\.averageIntensity).max() ?? 0
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            ForEach(dailyIntensities) { day in
                VStack(spacing: 6) {
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
        .frame(height: 74, alignment: .bottom)
    }

    private func isPeak(_ day: DayIntensity) -> Bool {
        peakIntensity > 0 && day.averageIntensity == peakIntensity
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
