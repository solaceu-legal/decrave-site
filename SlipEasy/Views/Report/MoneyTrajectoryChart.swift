//
//  MoneyTrajectoryChart.swift
//  SlipEasy
//

import SwiftUI
import Charts

struct MoneyTrajectoryChart: View {
    let points: [InsightsEngine.MoneyTrajectoryPoint]

    var body: some View {
        Chart(points) { point in
            AreaMark(
                x: .value("Month", point.month),
                y: .value("Saved", point.cumulativeSaved)
            )
            .foregroundStyle(LinearGradient.brand.opacity(0.15))
            .interpolationMethod(.catmullRom)

            LineMark(
                x: .value("Month", point.month),
                y: .value("Saved", point.cumulativeSaved)
            )
            .foregroundStyle(LinearGradient.brand)
            .interpolationMethod(.catmullRom)
        }
        .chartXAxis {
            AxisMarks(values: [0, (points.count - 1)]) { value in
                AxisValueLabel {
                    if let month = value.as(Int.self) {
                        Text(month == 0 ? "Now" : "\(month) mo")
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(values: .automatic(desiredCount: 3))
        }
        .frame(height: 140)
    }
}

#Preview {
    MoneyTrajectoryChart(points: InsightsEngine.moneyTrajectory(currentSaved: 47, perWeekSavings: 12))
        .padding()
}
