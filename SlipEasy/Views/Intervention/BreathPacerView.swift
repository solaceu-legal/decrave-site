//
//  BreathPacerView.swift
//  SlipEasy
//

import SwiftUI

/// The circle 4-7-8 breathing paces itself against — grows on inhale, holds
/// at full size, shrinks on exhale. Visual recipe (radial-gradient orb with
/// a two-layer glow, 1.0→1.3 scale, static hold — no pulse) matches
/// BreathingSessionView's orb in Lightvessel
/// (~/Developer/hearyou/hearyou/Views/BreathingSessionView.swift), same
/// developer's other app — minus its static outer ring, dropped per
/// product call to keep just the orb. A scattered-particle halo was tried
/// and dropped too: on a smoking-cessation app it read as lung/particulate
/// imagery, the opposite of calming.
///
/// Lightvessel drives its scale with withAnimation() timed off a
/// Task.sleep loop. This instead computes scale as a pure function of
/// (date - phaseStart) inside TimelineView(.animation), same wall-clock
/// philosophy as the phase timer in InterventionView: correct immediately
/// after the app returns from the background, with no animation state of
/// its own to desync.
struct BreathPacerView: View {
    let action: BreathAction
    let duration: Double
    let phaseStart: Date

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let minScale = 1.0
    private let maxScale = 1.3
    private let orbSize: CGFloat = 150

    var body: some View {
        Group {
            if reduceMotion {
                orb(scale: reducedMotionScale)
            } else {
                TimelineView(.animation) { context in
                    orb(scale: scale(at: context.date))
                }
            }
        }
        .accessibilityHidden(true)
    }

    private func orb(scale: Double) -> some View {
        Circle()
            .fill(
                RadialGradient(
                    colors: [
                        Color.white.opacity(0.9),
                        Color.accentColor.opacity(0.85),
                        Color.accentColor.opacity(0.5)
                    ],
                    center: .center,
                    startRadius: 0,
                    endRadius: orbSize * 0.67
                )
            )
            .frame(width: orbSize, height: orbSize)
            .shadow(color: Color.accentColor.opacity(0.45), radius: 30)
            .shadow(color: Color.accentColor.opacity(0.2), radius: 80)
            .scaleEffect(scale)
    }

    private var reducedMotionScale: Double {
        action == .exhale ? minScale : maxScale
    }

    private func scale(at date: Date) -> Double {
        let elapsed = date.timeIntervalSince(phaseStart)
        let progress = min(max(elapsed / duration, 0), 1)

        switch action {
        case .inhale:
            return minScale + (maxScale - minScale) * easeInOut(progress)
        case .exhale:
            return maxScale - (maxScale - minScale) * easeInOut(progress)
        case .hold:
            // Held breath holds still — no pulse. Matches Lightvessel: the
            // orb simply stays at the inhale peak until exhale begins.
            return maxScale
        }
    }

    private func easeInOut(_ t: Double) -> Double {
        t < 0.5 ? 4 * t * t * t : 1 - pow(-2 * t + 2, 3) / 2
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        BreathPacerView(action: .inhale, duration: 4, phaseStart: Date())
    }
}
