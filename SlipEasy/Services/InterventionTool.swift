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

    /// `variantIndex` only matters for Urge Surfing — it picks which of the
    /// 8 prompt sets to show (mod count, so any ever-increasing counter
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
