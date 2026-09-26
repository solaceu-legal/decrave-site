//
//  InterventionTool.swift
//  SlipEasy
//

import Foundation

/// Which part of a breath cycle a phase represents — nil for phases that
/// aren't breathing (e.g. all four Urge Surfing phases), so BreathPacerView
/// knows which way to animate and everything else can ignore it.
enum BreathAction: Equatable {
    case inhale, hold, exhale
}

struct InterventionPhase {
    let duration: Double
    let prompt: String
    var breathAction: BreathAction? = nil
}

enum InterventionTool: String, Hashable, Identifiable {
    case urgeSurfing = "urge_surfing"
    case breathing = "breathing"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .urgeSurfing:
            return Strings.localized("Urge surfing", [
                .simplifiedChinese: "乘风破浪", .traditionalChinese: "乘風破浪", .german: "Das Verlangen abklingen lassen",
                .french: "Laisser passer l’envie", .italian: "Lascia passare la voglia", .spanish: "Deja pasar las ganas",
                .portuguese: "Deixe a vontade passar", .japanese: "吸いたい気持ちをやり過ごす", .korean: "흡연 욕구 넘기기"
            ])
        case .breathing:
            return Strings.localized("Breathing", [
                .simplifiedChinese: "呼吸练习", .traditionalChinese: "呼吸練習", .german: "Atmung",
                .french: "Respiration", .italian: "Respirazione", .spanish: "Respiración",
                .portuguese: "Respiração", .japanese: "呼吸", .korean: "호흡"
            ])
        }
    }

    var subtitle: String {
        switch self {
        case .urgeSurfing:
            return Strings.localized("Notice the urge without acting on it.", [
                .simplifiedChinese: "看见冲动，但不跟着它行动。", .traditionalChinese: "看見衝動，但不跟著它行動。",
                .german: "Nimm das Verlangen wahr, ohne danach zu handeln.", .french: "Observe l'envie sans agir dessus.",
                .italian: "Nota l'impulso senza agire.", .spanish: "Observa el impulso sin actuar.",
                .portuguese: "Perceba a vontade sem agir sobre ela.", .japanese: "欲求に気づき、行動に移さない。", .korean: "충동을 알아차리되 행동으로 옮기지 않아요."
            ])
        case .breathing:
            return Strings.localized("A paced reset for the next few minutes.", [
                .simplifiedChinese: "跟着节奏呼吸几分钟。", .traditionalChinese: "跟著節奏呼吸幾分鐘。",
                .german: "Ein ruhiger Rhythmus für die nächsten Minuten.", .french: "Un rythme guidé pour les prochaines minutes.",
                .italian: "Un ritmo guidato per i prossimi minuti.", .spanish: "Un ritmo guiado para los próximos minutos.",
                .portuguese: "Um ritmo guiado para os próximos minutos.", .japanese: "数分間、呼吸のリズムを整える。", .korean: "몇 분 동안 호흡의 리듬을 되찾아요."
            ])
        }
    }

    var iconName: String {
        switch self {
        case .urgeSurfing: return "waveform.path.ecg"
        case .breathing: return "wind"
        }
    }

    /// `variantIndex` only matters for Urge Surfing — it picks which of the
    /// prompt sets to show (mod count, so any ever-increasing counter
    /// works as input). Breathing ignores it; its cues are functional
    /// (paced to the actual 4-7-8 rhythm), not flavor text to rotate.
    func phases(variantIndex: Int) -> [InterventionPhase] {
        switch self {
        case .urgeSurfing:
            let sets = Strings.Intervention.urgeSurfingPromptSets
            let prompts = sets[variantIndex % sets.count]
            let durations: [Double] = [20, 40, 60, 60]
            return zip(durations, prompts).map { InterventionPhase(duration: $0, prompt: $1) }
        case .breathing:
            // 4-7-8 technique: inhale 4s, hold 7s, exhale 8s. 4 cycles is
            // the commonly recommended starting count.
            let cycle = [
                InterventionPhase(duration: 4, prompt: Strings.Intervention.breatheInPrompt, breathAction: .inhale),
                InterventionPhase(duration: 7, prompt: Strings.Intervention.holdPrompt, breathAction: .hold),
                InterventionPhase(duration: 8, prompt: Strings.Intervention.breatheOutPrompt, breathAction: .exhale)
            ]
            return Array(repeating: cycle, count: 4).flatMap { $0 }
        }
    }
}
