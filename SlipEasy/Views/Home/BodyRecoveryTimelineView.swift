//
//  BodyRecoveryTimelineView.swift
//  SlipEasy
//
//  Commonly-cited smoking-cessation recovery timeframes (the same kind
//  public health sites like Smokefree.gov publish) — general physiological
//  facts, not a claim about what this app does or a promise for any one
//  person. Anchored to "time since last cigarette," which is a different,
//  resettable clock from the never-reset counters elsewhere on Home — see
//  HomeView for how the anchor date is chosen.
//

import SwiftUI

struct RecoveryMilestone {
    let duration: TimeInterval
}

enum RecoveryMilestones {
    static let all: [RecoveryMilestone] = [
        RecoveryMilestone(duration: 20 * 60),
        RecoveryMilestone(duration: 12 * 3600),
        RecoveryMilestone(duration: 14 * 86400),
        RecoveryMilestone(duration: 30 * 86400),
        RecoveryMilestone(duration: 270 * 86400),
        RecoveryMilestone(duration: 365 * 86400)
    ]
}

struct BodyRecoveryTimelineView: View {
    let since: Date
    @ScaledMetric(relativeTo: .caption) private var cardWidth: CGFloat = 132
    @ScaledMetric(relativeTo: .caption) private var cardContentHeight: CGFloat = 112

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(RecoveryMilestones.all, id: \.duration) { milestone in
                    milestoneCard(milestone)
                }
            }
        }
    }

    private func milestoneCard(_ milestone: RecoveryMilestone) -> some View {
        let elapsed = Date().timeIntervalSince(since)
        let progress = min(1, max(0, elapsed / milestone.duration))
        let reached = progress >= 1

        return VStack(alignment: .leading, spacing: 6) {
            Image(systemName: reached ? "checkmark.circle.fill" : "circle")
                .font(.callout)
                .foregroundStyle(reached ? Color.mint : Color.white.opacity(0.25))
            Text(Strings.Home.recoveryMilestoneLabel(duration: milestone.duration))
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(reached ? Color.mint : .secondary)
            Text(Strings.Home.recoveryMilestoneTitle(duration: milestone.duration))
                .font(.caption)
                .foregroundStyle(.primary)
                .lineLimit(4)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
            if reached {
                Text(Strings.Home.recoveryReached)
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(Color.mint)
            } else {
                ProgressView(value: progress)
                    .tint(Color.accentColor)
            }
        }
        .frame(width: cardWidth, height: cardContentHeight, alignment: .topLeading)
        .padding(12)
        .cardStyle()
    }
}

#Preview {
    BodyRecoveryTimelineView(since: Date().addingTimeInterval(-3 * 86400))
        .padding()
        .background(Color.appBackground)
}
