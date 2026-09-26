//
//  WidgetSharedState.swift
//  SlipEasy
//

import Foundation
import WidgetKit

struct WidgetSharedState: Codable {
    let dayKey: String
    let questKindRaw: String
    let triggerRaw: String?
    let questTitle: String
    let questBody: String
    let isCompleted: Bool
    let radarWeekday: Int?
    let radarHour: Int?
    let radarTriggerRaw: String?
    let radarTriggerLabel: String?
    let radarOccurrences: Int?
    let updatedAt: Date
}

enum WidgetSharedStore {
    static let appGroupID = "group.com.xhwang.SlipEasy"
    static let stateKey = "decrave.widget.sharedState"
    static let widgetKind = "DecraveWidget"

    static var defaults: UserDefaults? {
        UserDefaults(suiteName: appGroupID)
    }

    static func save(_ state: WidgetSharedState) {
        guard let data = try? JSONEncoder().encode(state) else { return }
        defaults?.set(data, forKey: stateKey)
    }

    static func saveLanguage(_ rawValue: String) {
        defaults?.set(rawValue, forKey: AppLanguage.storageKey)
        WidgetCenter.shared.reloadTimelines(ofKind: widgetKind)
    }

    static func dayKey(for date: Date = Date(), calendar: Calendar = .current) -> String {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return "\(components.year ?? 0)-\(components.month ?? 0)-\(components.day ?? 0)"
    }
}

enum WidgetSyncService {
    @MainActor
    static func sync(
        quest: DailyQuest,
        isCompleted: Bool,
        logs: [CravingLog],
        now: Date = Date()
    ) {
        let summaries = logs.map {
            LogSummary(
                timestamp: $0.timestamp,
                outcome: $0.outcome,
                trigger: $0.trigger,
                usedIntervention: $0.interventionTool != nil,
                interventionTool: $0.interventionTool
            )
        }
        let radar = ProAccess.isUnlocked
            ? InsightsEngine.predictedCravingWindow(logs: summaries)
            : nil

        let state = WidgetSharedState(
            dayKey: WidgetSharedStore.dayKey(for: now),
            questKindRaw: quest.kind.rawValue,
            triggerRaw: quest.trigger?.rawValue,
            questTitle: quest.title,
            questBody: quest.body,
            isCompleted: isCompleted,
            radarWeekday: radar?.weekday,
            radarHour: radar?.hour,
            radarTriggerRaw: radar?.trigger?.rawValue,
            radarTriggerLabel: radar?.trigger?.label,
            radarOccurrences: radar?.occurrences,
            updatedAt: now
        )
        WidgetSharedStore.save(state)
        WidgetSharedStore.saveLanguage(AppLanguage.current.rawValue)
    }
}
