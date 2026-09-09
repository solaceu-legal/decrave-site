//
//  PeakHoursChart.swift
//  SlipEasy
//
//  Craving frequency by hour of day, across all-time logs (same
//  reasoning as InsightsEngine.predictedCravingWindow — an hour-of-day
//  pattern needs more than a week of data to mean anything). Pro-gated,
//  so unlike the free-tier charts this uses Swift Charts directly
//  rather than matching the reference design's hand-drawn bar style.
//

import SwiftUI
import Charts

struct PeakHoursChart: View {
    let logs: [CravingLog]

    private struct HourCount: Identifiable {
        let hour: Int // 0...23
        let count: Int
        var id: Int { hour }
    }

    private var hourlyCounts: [HourCount] {
        let calendar = Calendar.current
        var counts = [Int: Int]()
        for log in logs {
            let hour = calendar.component(.hour, from: log.timestamp)
            counts[hour, default: 0] += 1
        }
        return (0..<24).map { HourCount(hour: $0, count: counts[$0] ?? 0) }
    }

    var peakHourLabel: String? {
        guard let peak = hourlyCounts.max(by: { $0.count < $1.count }), peak.count > 0 else { return nil }
        return Self.formattedHour(peak.hour)
    }

    var body: some View {
        if logs.isEmpty {
            Text(Strings.Report.notEnoughData)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        } else {
            Chart(hourlyCounts) { item in
                BarMark(
                    x: .value("Hour", item.hour),
                    y: .value("Count", item.count)
                )
                .foregroundStyle(LinearGradient.brand)
                // Skips zero-count hours — labeling all 24 bars would be
                // unreadable clutter, and a 0 bar is already invisible.
                .annotation(position: .top) {
                    if item.count > 0 {
                        Text("\(item.count)")
                            .font(.system(size: 8, weight: .semibold, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .chartXAxis {
                AxisMarks(values: [0, 6, 12, 18]) { value in
                    AxisValueLabel {
                        if let hour = value.as(Int.self) {
                            Text(Self.formattedHour(hour))
                        }
                    }
                }
            }
            .chartYAxis {
                AxisMarks(values: .automatic(desiredCount: 3))
            }
            .frame(height: 120)
        }
    }

    private static func formattedHour(_ hour: Int) -> String {
        var components = DateComponents()
        components.hour = hour
        let date = Calendar.current.date(from: components) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter.string(from: date)
    }
}

#Preview {
    PeakHoursChart(logs: [])
        .padding()
        .background(Color.appBackground)
}
