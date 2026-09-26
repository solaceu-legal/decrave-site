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
        case .coffee: return localized("Coffee", simplifiedChinese: "咖啡", traditionalChinese: "咖啡", german: "Kaffee", french: "Café", italian: "Caffè", spanish: "Café", portuguese: "Café", japanese: "コーヒー", korean: "커피")
        case .meal: return localized("Meal", simplifiedChinese: "饭后", traditionalChinese: "飯後", german: "Nach dem Essen", french: "Repas", italian: "Dopo il pasto", spanish: "Después de comer", portuguese: "Depois de comer", japanese: "食後", korean: "식사 후")
        case .stress: return localized("Stress", simplifiedChinese: "压力", traditionalChinese: "壓力", german: "Stress", french: "Stress", italian: "Stress", spanish: "Estrés", portuguese: "Estresse", japanese: "ストレス", korean: "스트레스")
        case .alcohol: return localized("Alcohol", simplifiedChinese: "酒后", traditionalChinese: "酒後", german: "Alkohol", french: "Alcool", italian: "Alcol", spanish: "Alcohol", portuguese: "Álcool", japanese: "飲酒", korean: "술자리")
        case .breakTime: return localized("Break", simplifiedChinese: "休息时", traditionalChinese: "休息時", german: "Pause", french: "Pause", italian: "Pausa", spanish: "Descanso", portuguese: "Pausa", japanese: "休憩", korean: "휴식")
        case .boredom: return localized("Boredom", simplifiedChinese: "无聊", traditionalChinese: "無聊", german: "Langeweile", french: "Ennui", italian: "Noia", spanish: "Aburrimiento", portuguese: "Tédio", japanese: "退屈", korean: "지루함")
        case .other: return localized("Other", simplifiedChinese: "其他", traditionalChinese: "其他", german: "Andere", french: "Autre", italian: "Altro", spanish: "Otro", portuguese: "Outro", japanese: "その他", korean: "기타")
        }
    }

    private func localized(_ english: String, simplifiedChinese: String, traditionalChinese: String, german: String, french: String, italian: String, spanish: String, portuguese: String, japanese: String, korean: String) -> String {
        switch AppLanguage.current.effective {
        case .simplifiedChinese: simplifiedChinese
        case .traditionalChinese: traditionalChinese
        case .german: german
        case .french: french
        case .italian: italian
        case .spanish: spanish
        case .portuguese: portuguese
        case .japanese: japanese
        case .korean: korean
        default: english
        }
    }

    var iconName: String {
        switch self {
        case .coffee: return "cup.and.saucer.fill"
        case .meal: return "fork.knife"
        case .stress: return "bolt.fill"
        case .alcohol: return "wineglass.fill"
        case .breakTime: return "clock.fill"
        case .boredom: return "zzz"
        case .other: return "ellipsis.circle.fill"
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
    // nil = logged directly with no intervention tool attempt (e.g. Home's
    // "I smoked" button); set = this log followed a completed intervention.
    var interventionToolRaw: String?

    init() {}

    var outcome: CravingOutcome {
        get { CravingOutcome(rawValue: outcomeRaw) ?? .beaten }
        set { outcomeRaw = newValue.rawValue }
    }

    var trigger: CravingTrigger? {
        get { triggerRaw.flatMap { CravingTrigger(rawValue: $0) } }
        set { triggerRaw = newValue?.rawValue }
    }

    var interventionTool: InterventionTool? {
        get { interventionToolRaw.flatMap { InterventionTool(rawValue: $0) } }
        set { interventionToolRaw = newValue?.rawValue }
    }
}
