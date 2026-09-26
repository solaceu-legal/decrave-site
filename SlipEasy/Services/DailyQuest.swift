//
//  DailyQuest.swift
//  SlipEasy
//

import Foundation

enum DailyQuestKind: String, CaseIterable, Identifiable {
    case practiceTool = "practice_tool"
    case captureCraving = "capture_craving"
    case nameTrigger = "name_trigger"

    var id: String { rawValue }
}

struct DailyQuest: Equatable {
    let kind: DailyQuestKind
    let trigger: CravingTrigger?

    var id: String {
        "\(kind.rawValue):\(trigger?.rawValue ?? "any")"
    }

    var title: String {
        switch kind {
        case .practiceTool:
            return Strings.Home.questPracticeTitle
        case .captureCraving:
            return Strings.Home.questCaptureTitle
        case .nameTrigger:
            return Strings.Home.questTriggerTitle
        }
    }

    var body: String {
        switch kind {
        case .practiceTool:
            return Strings.Home.questPracticeBody
        case .captureCraving:
            return Strings.Home.questCaptureBody
        case .nameTrigger:
            return Strings.Home.questTriggerBody(trigger: trigger?.label)
        }
    }

    var actionTitle: String {
        switch kind {
        case .practiceTool:
            return Strings.Home.questPracticeCTA
        case .captureCraving:
            return Strings.Home.questCaptureCTA
        case .nameTrigger:
            return Strings.Home.questTriggerCTA
        }
    }
}

enum DailyQuestEngine {
    static func dayKey(for date: Date, calendar: Calendar = .current) -> String {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return "\(components.year ?? 0)-\(components.month ?? 0)-\(components.day ?? 0)"
    }

    static func defaultKind(for date: Date, calendar: Calendar = .current) -> DailyQuestKind {
        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: date) ?? 1
        let index = max(0, dayOfYear - 1) % DailyQuestKind.allCases.count
        return DailyQuestKind.allCases[index]
    }

    static func relevantTrigger(in logs: [CravingLog], now: Date = Date(), calendar: Calendar = .current) -> CravingTrigger? {
        let today = calendar.startOfDay(for: now)
        guard let windowStart = calendar.date(byAdding: .day, value: -30, to: today) else { return nil }

        var counts: [CravingTrigger: Int] = [:]
        var latest: [CravingTrigger: Date] = [:]
        for log in logs where log.timestamp >= windowStart && log.timestamp <= now {
            guard let trigger = log.trigger else { continue }
            counts[trigger, default: 0] += 1
            if log.timestamp > (latest[trigger] ?? .distantPast) {
                latest[trigger] = log.timestamp
            }
        }

        return counts.max { left, right in
            if left.value != right.value { return left.value < right.value }
            return (latest[left.key] ?? .distantPast) < (latest[right.key] ?? .distantPast)
        }?.key
    }

    static func isCompleted(_ quest: DailyQuest, in logs: [CravingLog], since startOfDay: Date) -> Bool {
        let todaysLogs = logs.filter { $0.timestamp >= startOfDay }
        switch quest.kind {
        case .practiceTool:
            return todaysLogs.contains { $0.interventionTool != nil }
        case .captureCraving:
            return !todaysLogs.isEmpty
        case .nameTrigger:
            if let trigger = quest.trigger {
                return todaysLogs.contains { $0.trigger == trigger }
            }
            return todaysLogs.contains { $0.trigger != nil }
        }
    }
}
