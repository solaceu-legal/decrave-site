//
//  ConfettiView.swift
//  SlipEasy
//
//  A short-lived burst of falling rectangles for the "craving beaten"
//  moment — plain velocity/gravity math on a Canvas, not a physics
//  engine, so it's cheap enough to fire on every win. Respects Reduce
//  Motion by not firing at all.
//

import SwiftUI

struct ConfettiView: View {
    let trigger: Bool

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var particles: [Particle] = []
    @State private var startTime: Date?

    private struct Particle {
        var x: Double
        var vx: Double
        var vy: Double
        var rotation: Double
        var rotationSpeed: Double
        var color: Color
        var size: Double
    }

    private static let colors: [Color] = [.mint, .cyan, .purple, .gold, .coral]
    private static let lifetime: Double = 1.8

    var body: some View {
        TimelineView(.animation(paused: particles.isEmpty)) { context in
            Canvas { ctx, size in
                guard let startTime else { return }
                let t = context.date.timeIntervalSince(startTime)
                guard t < Self.lifetime else { return }
                let opacity = max(0, 1 - t / Self.lifetime)
                for particle in particles {
                    let x = particle.x + particle.vx * t
                    let y = size.height * 0.35 + particle.vy * t + 0.5 * 480 * t * t
                    var transform = CGAffineTransform(translationX: x, y: y)
                    transform = transform.rotated(by: particle.rotation + particle.rotationSpeed * t)
                    let rect = CGRect(x: -particle.size / 2, y: -particle.size / 2 * 0.6, width: particle.size, height: particle.size * 0.6)
                    ctx.opacity = opacity
                    ctx.fill(Path(rect).applying(transform), with: .color(particle.color))
                }
            }
        }
        .allowsHitTesting(false)
        .onChange(of: trigger) { _, newValue in
            if newValue { fire() }
        }
    }

    private func fire() {
        guard !reduceMotion else { return }
        startTime = Date()
        particles = (0..<70).map { _ in
            Particle(
                x: Double.random(in: 60...340),
                vx: Double.random(in: -110...110),
                vy: Double.random(in: -420 ... -160),
                rotation: Double.random(in: 0...(2 * .pi)),
                rotationSpeed: Double.random(in: -6...6),
                color: Self.colors.randomElement()!,
                size: Double.random(in: 6...12)
            )
        }
        Task {
            try? await Task.sleep(for: .seconds(Self.lifetime + 0.2))
            particles = []
        }
    }
}
