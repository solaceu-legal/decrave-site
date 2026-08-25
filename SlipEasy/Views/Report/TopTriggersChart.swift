//
//  TopTriggersChart.swift
//  SlipEasy
//

import SwiftUI
import Charts

/// Counts both outcomes — a trigger applies to the craving whether or
/// not it was beaten.
struct TopTriggersChart: View {
    let logs: [CravingLog]

    private struct TriggerCount: Identifiable {
        let trigger: CravingTrigger
        let count: Int
        var id: String { trigger.rawValue }
    }

    private var topTriggers: [TriggerCount] {
        var counts = [CravingTrigger: Int]()
        for log in logs {
            guard let trigger = log.trigger else { continue }
            counts[trigger, default: 0] += 1
        }
        let ranked = counts
            .map { TriggerCount(trigger: $0.key, count: $0.value) }
            .sorted { $0.count > $1.count }
        return Array(ranked.prefix(3))
    }

    var body: some View {
        if topTriggers.isEmpty {
            Text(Strings.Report.notEnoughData)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        } else {
            Chart(topTriggers) { item in
                BarMark(
                    x: .value("Count", item.count),
                    y: .value("Trigger", item.trigger.label)
                )
                .foregroundStyle(Color.accentColor)
            }
            .frame(height: 120)
        }
    }
}

#Preview {
    TopTriggersChart(logs: [])
}
