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
    let label: String
    let title: String
}

enum RecoveryMilestones {
    static let all: [RecoveryMilestone] = [
        RecoveryMilestone(duration: 20 * 60, label: "20 MIN", title: "Heart rate and blood pressure start to drop"),
        RecoveryMilestone(duration: 12 * 3600, label: "12 HRS", title: "Blood oxygen levels normalize"),
        RecoveryMilestone(duration: 14 * 86400, label: "2 WEEKS", title: "Circulation starts improving"),
        RecoveryMilestone(duration: 30 * 86400, label: "1 MONTH", title: "Lung function starts improving"),
        RecoveryMilestone(duration: 270 * 86400, label: "9 MONTHS", title: "Coughing and shortness of breath decrease"),
        RecoveryMilestone(duration: 365 * 86400, label: "1 YEAR", title: "Added heart disease risk is about half")
    ]
}

struct BodyRecoveryTimelineView: View {
    let since: Date

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(RecoveryMilestones.all, id: \.label) { milestone in
                    milestoneCard(milestone)
                }
            }
        }
    }

    private func milestoneCard(_ milestone: RecoveryMilestone) -> some View {
        let elapsed = Date().timeIntervalSince(since)
        let progress = min(1, max(0, elapsed / milestone.duration))
        let reached = progress >= 1

        return VStack(alignment: .leading, spacing: 8) {
            Image(systemName: reached ? "checkmark.circle.fill" : "circle")
                .font(.callout)
                .foregroundStyle(reached ? Color.mint : Color.white.opacity(0.25))
            Text(milestone.label)
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(reached ? Color.mint : .secondary)
            Text(milestone.title)
                .font(.caption)
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
            if !reached {
                ProgressView(value: progress)
                    .tint(Color.accentColor)
            }
        }
        .frame(width: 132, alignment: .leading)
        .padding(12)
        .cardStyle()
    }
}

#Preview {
    BodyRecoveryTimelineView(since: Date().addingTimeInterval(-3 * 86400))
        .padding()
        .background(Color.appBackground)
}
