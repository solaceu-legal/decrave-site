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
}

enum Milestones {
    static let all: [Milestone] = [
        Milestone(threshold: 10, icon: "flame.fill", label: "10 beaten"),
        Milestone(threshold: 25, icon: "bolt.fill", label: "25 beaten"),
        Milestone(threshold: 50, icon: "star.fill", label: "50 beaten"),
        Milestone(threshold: 100, icon: "crown.fill", label: "100 beaten")
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
                Circle()
                    .fill(reached ? AnyShapeStyle(LinearGradient.brand) : AnyShapeStyle(Color.white.opacity(0.06)))
                    .frame(width: 56, height: 56)
                Image(systemName: milestone.icon)
                    .foregroundStyle(reached ? Color.black.opacity(0.7) : Color.white.opacity(0.25))
            }
            Text(milestone.label)
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(reached ? .primary : .secondary)
        }
    }
}

#Preview {
    MilestonesRow(beatenCount: 12)
        .padding()
        .background(Color.appBackground)
}
