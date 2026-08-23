//
//  CravingLog.swift
//  SlipEasy
//

import Foundation
import SwiftData

enum CravingOutcome: String, Hashable {
    case beaten
    case smoked
}

enum CravingTrigger: String, CaseIterable, Identifiable {
    case coffee
    case meal
    case stress
    case alcohol
    case breakTime
    case boredom
    case other

    var id: String { rawValue }

    var label: String {
        switch self {
        case .coffee: return "Coffee"
        case .meal: return "Meal"
        case .stress: return "Stress"
        case .alcohol: return "Alcohol"
        case .breakTime: return "Break"
        case .boredom: return "Boredom"
        case .other: return "Other"
        }
    }
}

@Model
final class CravingLog {
    var timestamp: Date = Date()
    var outcomeRaw: String = CravingOutcome.beaten.rawValue
    var triggerRaw: String?
    var intensity: Int = 3
    var id: UUID = UUID()

    init() {}

    var outcome: CravingOutcome {
        get { CravingOutcome(rawValue: outcomeRaw) ?? .beaten }
        set { outcomeRaw = newValue.rawValue }
    }

    var trigger: CravingTrigger? {
        get { triggerRaw.flatMap { CravingTrigger(rawValue: $0) } }
        set { triggerRaw = newValue?.rawValue }
    }
}
