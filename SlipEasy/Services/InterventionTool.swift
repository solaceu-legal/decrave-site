//
//  InterventionTool.swift
//  SlipEasy
//

import Foundation

struct InterventionPhase {
    let duration: Double
    let prompt: String
}

enum InterventionTool: String, Hashable, Identifiable {
    case urgeSurfing = "urge_surfing"
    case breathing = "breathing"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .urgeSurfing: return Strings.Intervention.urgeSurfingTitle
        case .breathing: return Strings.Intervention.breathingTitle
        }
    }

    var subtitle: String {
        switch self {
        case .urgeSurfing: return Strings.Intervention.urgeSurfingSubtitle
        case .breathing: return Strings.Intervention.breathingSubtitle
        }
    }

    var phases: [InterventionPhase] {
        switch self {
        case .urgeSurfing:
            return [
                InterventionPhase(duration: 20, prompt: Strings.Intervention.phase1Prompt),
                InterventionPhase(duration: 40, prompt: Strings.Intervention.phase2Prompt),
                InterventionPhase(duration: 60, prompt: Strings.Intervention.phase3Prompt),
                InterventionPhase(duration: 60, prompt: Strings.Intervention.phase4Prompt)
            ]
        case .breathing:
            // 4-7-8 technique: inhale 4s, hold 7s, exhale 8s. 4 cycles is
            // the commonly recommended starting count.
            let cycle = [
                InterventionPhase(duration: 4, prompt: Strings.Intervention.breatheInPrompt),
                InterventionPhase(duration: 7, prompt: Strings.Intervention.holdPrompt),
                InterventionPhase(duration: 8, prompt: Strings.Intervention.breatheOutPrompt)
            ]
            return Array(repeating: cycle, count: 4).flatMap { $0 }
        }
    }
}
