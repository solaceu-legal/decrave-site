//
//  InterventionProgressIndicator.swift
//  SlipEasy
//

import SwiftUI

/// Bottom-of-screen progress for InterventionView. No countdown numbers on
/// purpose — see InterventionView's phase-advance logic: a precise "0:47"
/// implies the craving is scheduled to end when it hits zero, which is
/// exactly the promise this exercise doesn't make.
///
/// Urge Surfing gets one segment per phase (4, unchanged from the original
/// design). Breathing would make that 12 slivers for its 4 cycles × 3
/// phases, which is hard to read at a glance — it gets one dot per full
/// breath cycle instead, so "how many breaths left" is legible at a glance.
struct InterventionProgressIndicator: View {
    let tool: InterventionTool
    let phases: [InterventionPhase]
    let phaseIndex: Int
    let elapsedInPhase: Double

    private let phasesPerCycle = 3

    var body: some View {
        switch tool {
        case .urgeSurfing:
            HStack(spacing: 6) {
                ForEach(phases.indices, id: \.self) { index in
                    segmentBar(fraction: segmentFraction(for: index))
                }
            }
            .frame(height: 4)
        case .breathing:
            HStack(spacing: 8) {
                ForEach(0..<(phases.count / phasesPerCycle), id: \.self) { cycleIndex in
                    dot(completed: cycleIndex < phaseIndex / phasesPerCycle)
                }
            }
        }
    }

    // MARK: - Urge Surfing: one segment per phase

    private func segmentFraction(for index: Int) -> CGFloat {
        if index < phaseIndex { return 1 }
        if index > phaseIndex { return 0 }
        return CGFloat(min(elapsedInPhase / phases[index].duration, 1))
    }

    private func segmentBar(fraction: CGFloat) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule().fill(Color.white.opacity(0.25))
                Capsule()
                    .fill(Color.white)
                    .frame(width: geometry.size.width * fraction)
            }
        }
        .animation(.linear(duration: 0.2), value: fraction)
    }

    // MARK: - Breathing: one dot per full cycle

    /// Binary, not a fill fraction — matches Lightvessel's roundDots
    /// (BreathingSessionView.swift): a round only lights up once it's
    /// fully done, the in-progress round looks the same as the ones still
    /// to come. The pacer circle above already shows moment-to-moment
    /// progress; this row is just a tally.
    private func dot(completed: Bool) -> some View {
        Circle()
            .fill(completed ? Color.accentColor : Color.clear)
            .overlay(Circle().stroke(Color.accentColor.opacity(0.5), lineWidth: 1))
            .frame(width: 7, height: 7)
            .animation(.easeInOut(duration: 0.2), value: completed)
    }
}

#Preview("Urge Surfing") {
    ZStack {
        Color.black.ignoresSafeArea()
        InterventionProgressIndicator(tool: .urgeSurfing, phases: InterventionTool.urgeSurfing.phases(variantIndex: 0), phaseIndex: 1, elapsedInPhase: 10)
            .padding(.horizontal, 48)
    }
}

#Preview("Breathing") {
    ZStack {
        Color.black.ignoresSafeArea()
        InterventionProgressIndicator(tool: .breathing, phases: InterventionTool.breathing.phases(variantIndex: 0), phaseIndex: 4, elapsedInPhase: 3)
            .padding(.horizontal, 48)
    }
}
