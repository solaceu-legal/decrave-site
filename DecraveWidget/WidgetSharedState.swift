//
//  WidgetSharedState.swift
//  DecraveWidget
//

import Foundation

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

    static func load() -> WidgetSharedState? {
        guard let data = defaults?.data(forKey: stateKey) else { return nil }
        return try? JSONDecoder().decode(WidgetSharedState.self, from: data)
    }

    static func dayKey(for date: Date = Date(), calendar: Calendar = .current) -> String {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return "\(components.year ?? 0)-\(components.month ?? 0)-\(components.day ?? 0)"
    }
}
