//
//  UrgeAmbientView.swift
//  SlipEasy
//

import SwiftUI

/// A slow, purely decorative glow behind the Urge Surfing text — keeps the
/// 20/40/60/60s phases from feeling static without representing anything.
/// It never syncs to phase boundaries or claims to track craving intensity:
/// this exercise doesn't promise the craving follows any particular curve,
/// so nothing on screen should look like it's charting one.
struct UrgeAmbientView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let minOpacity = 0.15
    private let maxOpacity = 0.3
    private let period = 6.0

    var body: some View {
        Group {
            if reduceMotion {
                glow(opacity: (minOpacity + maxOpacity) / 2)
            } else {
                TimelineView(.animation) { context in
                    glow(opacity: opacity(at: context.date))
                }
            }
        }
        .accessibilityHidden(true)
    }

    private func glow(opacity: Double) -> some View {
        Circle()
            .fill(
                RadialGradient(
                    colors: [Color.accentColor.opacity(opacity), Color.clear],
                    center: .center,
                    startRadius: 0,
                    endRadius: 220
                )
            )
            .frame(width: 440, height: 440)
    }

    /// No stored start time on purpose — an absolute phase offset doesn't
    /// matter for a purely ambient loop, so this needs no @State at all.
    private func opacity(at date: Date) -> Double {
        let t = date.timeIntervalSinceReferenceDate
        let pulse = (sin(t * 2 * .pi / period) + 1) / 2
        return minOpacity + (maxOpacity - minOpacity) * pulse
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        UrgeAmbientView()
    }
}
