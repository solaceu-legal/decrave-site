//
//  PeakHoursChart.swift
//  SlipEasy
//

import SwiftUI
import Charts

/// Craving count by hour of day, not outcome-specific — the craving
/// itself is the event being tracked here, regardless of whether it was
/// beaten or smoked.
struct PeakHoursChart: View {
    let logs: [CravingLog]

    private struct HourCount: Identifiable {
        let hour: Int
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
                .foregroundStyle(Color.accentColor)
            }
            .chartXAxis {
                AxisMarks(values: [0, 6, 12, 18, 23]) { value in
                    AxisGridLine()
                    AxisValueLabel {
                        if let hour = value.as(Int.self) {
                            Text(hourLabel(hour))
                        }
                    }
                }
            }
            .frame(height: 160)
        }
    }

    private func hourLabel(_ hour: Int) -> String {
        let date = Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: Date()) ?? Date()
        return date.formatted(.dateTime.hour())
    }
}

#Preview {
    PeakHoursChart(logs: [])
}
