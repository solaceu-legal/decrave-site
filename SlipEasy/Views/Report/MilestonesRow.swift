//
//  MilestonesRow.swift
//  SlipEasy
//
//  Badges keyed to the never-reset "cravings beaten" count, not to a
//  day-streak — a streak-based milestone would quietly reintroduce the
//  same reset psychology the rest of the app avoids.
//

import SwiftUI

struct Milestone {
    let threshold: Int
    let icon: String
    let label: String
    let tier: MedalTier
}

/// Purely a material/color treatment for reached badges — thresholds
/// climbing through four tiers gives the row a sense of escalating
/// weight, the way real bronze/silver/gold medals read at a glance.
/// Unreached badges ignore this entirely and stay the flat dim circle.
enum MedalTier {
    case bronze, silver, gold, prestige

    var face: RadialGradient {
        RadialGradient(colors: faceColors, center: UnitPoint(x: 0.35, y: 0.3), startRadius: 0, endRadius: 30)
    }

    var rim: LinearGradient {
        LinearGradient(colors: rimColors, startPoint: .top, endPoint: .bottom)
    }

    var iconColor: Color {
        switch self {
        case .bronze: Color(red: 0.290, green: 0.180, blue: 0.078)
        case .silver: Color(red: 0.294, green: 0.318, blue: 0.345)
        case .gold: Color(red: 0.478, green: 0.306, blue: 0.047)
        case .prestige: Color(red: 0.043, green: 0.165, blue: 0.165)
        }
    }

    private var faceColors: [Color] {
        switch self {
        case .bronze:
            [Color(red: 0.906, green: 0.698, blue: 0.494), Color(red: 0.722, green: 0.451, blue: 0.200), Color(red: 0.431, green: 0.243, blue: 0.106)]
        case .silver:
            [Color(white: 0.980), Color(red: 0.780, green: 0.804, blue: 0.831), Color(red: 0.490, green: 0.514, blue: 0.549)]
        case .gold:
            [Color(red: 1.0, green: 0.933, blue: 0.761), Color.gold, Color(red: 0.722, green: 0.451, blue: 0.059)]
        case .prestige:
            // Same three stops as LinearGradient.brand — the highest tier
            // borrows the app's own hero gradient instead of a fourth
            // invented metal.
            [Color(red: 0.231, green: 0.910, blue: 0.690), Color.sky, Color.violet]
        }
    }

    private var rimColors: [Color] {
        switch self {
        case .bronze: [Color(red: 0.953, green: 0.796, blue: 0.620), Color(red: 0.290, green: 0.180, blue: 0.078)]
        case .silver: [.white, Color(red: 0.365, green: 0.388, blue: 0.420)]
        case .gold: [Color(red: 1.0, green: 0.953, blue: 0.839), Color(red: 0.478, green: 0.306, blue: 0.047)]
        case .prestige: [Color(red: 0.839, green: 0.973, blue: 0.933), Color(red: 0.290, green: 0.243, blue: 0.588)]
        }
    }
}

enum Milestones {
    static let all: [Milestone] = [
        Milestone(threshold: 10, icon: "flame.fill", label: "10 beaten", tier: .bronze),
        Milestone(threshold: 25, icon: "bolt.fill", label: "25 beaten", tier: .bronze),
        Milestone(threshold: 50, icon: "star.fill", label: "50 beaten", tier: .silver),
        Milestone(threshold: 100, icon: "crown.fill", label: "100 beaten", tier: .silver),
        Milestone(threshold: 200, icon: "rosette", label: "200 beaten", tier: .silver),
        Milestone(threshold: 500, icon: "medal.fill", label: "500 beaten", tier: .gold),
        Milestone(threshold: 1000, icon: "trophy.fill", label: "1,000 beaten", tier: .gold),
        Milestone(threshold: 2000, icon: "shield.fill", label: "2,000 beaten", tier: .prestige),
        Milestone(threshold: 5000, icon: "sparkles", label: "5,000 beaten", tier: .prestige),
        Milestone(threshold: 10000, icon: "infinity", label: "10,000 beaten", tier: .prestige)
    ]
}

struct MilestonesRow: View {
    let beatenCount: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(Milestones.all, id: \.threshold) { milestone in
                    badge(for: milestone)
                }
            }
        }
    }

    private func badge(for milestone: Milestone) -> some View {
        let reached = beatenCount >= milestone.threshold
        return VStack(spacing: 6) {
            ZStack {
                if reached {
                    Circle()
                        .fill(milestone.tier.rim)
                    Circle()
                        .fill(milestone.tier.face)
                        .padding(4)
                    // A soft highlight offset toward the upper-left, as if
                    // lit from one side — the detail that reads as "curved
                    // metal" rather than a flat tinted disc.
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.white.opacity(0.65), Color.white.opacity(0)],
                                center: UnitPoint(x: 0.32, y: 0.28),
                                startRadius: 0,
                                endRadius: 24
                            )
                        )
                        .padding(4)
                } else {
                    Circle()
                        .fill(Color.white.opacity(0.06))
                }
                Image(systemName: milestone.icon)
                    .foregroundStyle(reached ? milestone.tier.iconColor : Color.white.opacity(0.25))
            }
            .frame(width: 56, height: 56)
            .shadow(color: reached ? Color.black.opacity(0.35) : .clear, radius: 4, y: 2)

            Text(milestone.label)
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(reached ? .primary : .secondary)
        }
    }
}

#Preview {
    MilestonesRow(beatenCount: 1200)
        .padding()
        .background(Color.appBackground)
}
