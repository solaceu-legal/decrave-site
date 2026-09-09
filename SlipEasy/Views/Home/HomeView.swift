//
//  HomeView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Binding var path: [AppRoute]
    var onOpenInsights: () -> Void = {}
    var onStartQuest: () -> Void = {}

    @Environment(\.modelContext) private var modelContext

    @Query(
        filter: #Predicate<CravingLog> { $0.outcomeRaw == "beaten" },
        sort: \CravingLog.timestamp
    )
    private var beatenLogs: [CravingLog]

    @Query(
        filter: #Predicate<CravingLog> { $0.outcomeRaw == "smoked" },
        sort: \CravingLog.timestamp
    )
    private var smokedLogs: [CravingLog]

    @Query private var reductionPlans: [ReductionPlan]
    private var plan: ReductionPlan? { reductionPlans.first }

    @AppStorage("onboardingStatus") private var onboardingStatus: String = ""
    @AppStorage("pricePerPack") private var pricePerPack: Double = 8.5

    @State private var activeSheet: HomeSheet?

    // Scales with Dynamic Type. Sized to fit two side-by-side hero
    // numbers (money saved and cravings beaten, see heroCard) at their
    // typical lengths without either one needing to shrink more than
    // the other — a smaller shared size, rather than each Text's own
    // minimumScaleFactor racing independently, is what keeps them
    // rendering at the same height.
    @ScaledMetric(relativeTo: .title) private var numberSize: CGFloat = 38

    // Roughly what public health sources cite as an average smoking
    // break — an approximation in the same spirit as the 20/pack figure
    // used elsewhere (InsightsEngine.moneySaved), not a precise
    // per-user measurement.
    private static let minutesPerCigarette = 6

    private var beatenCount: Int { beatenLogs.count }

    private var moneySaved: Double {
        InsightsEngine.moneySaved(beatenCount: beatenCount, pricePerPack: pricePerPack)
    }

    private var momentum: Int {
        InsightsEngine.momentumScore(beatenCount: beatenCount, smokedCount: smokedLogs.count)
    }

    private var formattedMoneySaved: String {
        InsightsEngine.formattedMoneyCompact(moneySaved)
    }

    private var timeReclaimedText: String {
        let totalMinutes = beatenCount * Self.minutesPerCigarette
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        }
        return "\(minutes)m"
    }

    // "Time since last cigarette" is a separate, resettable clock from
    // the never-reset counters above — prefers an unbroken quit date if
    // one's been set, otherwise falls back to the most recent smoked
    // log. Nil (never smoked-logged, no quit date) hides the timeline
    // rather than inventing a start date.
    private var recoveryAnchor: Date? {
        if let quitDate = plan?.quitDate, !smokedLogs.contains(where: { $0.timestamp > quitDate }) {
            return quitDate
        }
        return smokedLogs.last?.timestamp
    }

    private var allLogSummaries: [LogSummary] {
        (beatenLogs + smokedLogs).map {
            LogSummary(timestamp: $0.timestamp, outcome: $0.outcome, trigger: $0.trigger, usedIntervention: $0.interventionTool != nil)
        }
    }

    private var prediction: InsightsEngine.PredictedWindow? {
        InsightsEngine.predictedCravingWindow(logs: allLogSummaries)
    }

    var body: some View {
        // A plain top-down stack of full-width cards — matches Decrave's
        // Home layout, where every section is the same card module edge
        // to edge.
        ScrollView {
            VStack(spacing: 16) {
                heroCard

                if onboardingStatus != "A", plan?.quitDate == nil {
                    ReductionGoalCard(
                        plan: plan,
                        smokedLogs: smokedLogs,
                        onSetGoal: { activeSheet = .setGoal }
                    )
                }

                // Not a NavigationLink to the full report anymore — that
                // now lives in the Insights tab (see MainFlowView).
                weeklyCard

                if let recoveryAnchor {
                    bodyRecoveryCard(since: recoveryAnchor)
                }

                TriggerRadarPreviewCard(prediction: prediction, onTap: onOpenInsights)

                TodaysQuestCard(onAccept: onStartQuest)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
            .padding(.bottom, Layout.tabBarClearance)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .onAppear {
            reconcileReductionPlans()
            checkQuitDateProposal()
        }
        // CloudKit-backed @Query results can still be settling in
        // (a second device's record arriving via sync) a moment after
        // onAppear already fired once — react whenever the result set
        // itself changes, not just at the first appearance.
        .onChange(of: reductionPlans) { _, _ in
            reconcileReductionPlans()
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .setGoal:
                SetGoalSheet(plan: plan, onSave: { activeSheet = nil })
            case .quitDateProposal:
                QuitDateProposalSheet(
                    onAccept: { activeSheet = .quitDatePicker },
                    onDecline: {
                        plan?.quitDateDeclinedAt = Date()
                        activeSheet = nil
                    }
                )
            case .quitDatePicker:
                if let plan {
                    QuitDatePickerSheet(plan: plan, onSave: { activeSheet = nil })
                }
            }
        }
    }

    // Money saved and cravings beaten are Decrave's two never-reset
    // counters — shown as equal-weight twins side by side, rather than
    // one dominant hero number with the other as an afterthought.
    // Momentum (which can dip) deliberately stays a smaller ring below,
    // not competing with either.
    private var heroCard: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 12) {
                heroStat(value: formattedMoneySaved, caption: Strings.Home.moneySavedCaption, style: AnyShapeStyle(LinearGradient.brand))
                heroStat(value: "\(beatenCount)", caption: Strings.Home.cravingsBeaten, style: AnyShapeStyle(Color.violet))
            }

            HStack(spacing: 6) {
                MomentumRingView(score: momentum)
                Text(Strings.Home.momentumLabel)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 8) {
                statChip(icon: "flame.fill", text: Strings.Home.cigsAvoided(beatenCount))
                statChip(icon: "clock.fill", text: Strings.Home.timeReclaimed(timeReclaimedText))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .cardStyle(elevated: true)
    }

    private func heroStat(value: String, caption: String, style: AnyShapeStyle) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: numberSize, weight: .bold, design: .rounded))
                .foregroundStyle(style)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            Text(caption)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }

    private func statChip(icon: String, text: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption2)
            Text(text)
                .font(.caption)
                .fontWeight(.semibold)
        }
        .foregroundStyle(.primary)
        .padding(.horizontal, 12)
        .padding(.vertical, 7)
        .background(Color.white.opacity(0.06))
        .clipShape(Capsule())
    }

    private func bodyRecoveryCard(since: Date) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(Strings.Home.bodyRecoveryTitle)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(Color.accentColor)
            BodyRecoveryTimelineView(since: since)
        }
        .padding(20)
        .cardStyle()
    }

    private var weeklyCard: some View {
        VStack(spacing: 12) {
            Text(Strings.Home.last7Days)
                .font(.caption)
                .foregroundStyle(.secondary)
            WeeklyBarsView(logs: beatenLogs)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .cardStyle()
    }

    /// CloudKit can't enforce a singleton (no @Attribute(.unique) allowed),
    /// so two devices that each set a goal before sync caught up end up
    /// with two separate ReductionPlan records — each device's `.first`
    /// then picks a different one, showing different targets. Once sync
    /// brings both records to the same device, merge them into one and
    /// delete the rest; the deletion syncs back out to reconcile everyone
    /// else. Keeps whichever target was set most recently, but won't
    /// discard a quit date or a decline timestamp just because it happened
    /// to land on the "losing" record.
    private func reconcileReductionPlans() {
        guard reductionPlans.count > 1 else { return }
        let ranked = reductionPlans.sorted {
            ($0.targetSetDate ?? .distantPast) > ($1.targetSetDate ?? .distantPast)
        }
        let winner = ranked[0]
        for duplicate in ranked.dropFirst() {
            if winner.quitDate == nil, let quitDate = duplicate.quitDate {
                winner.quitDate = quitDate
            }
            if let declinedAt = duplicate.quitDateDeclinedAt,
               (winner.quitDateDeclinedAt ?? .distantPast) < declinedAt {
                winner.quitDateDeclinedAt = declinedAt
            }
            modelContext.delete(duplicate)
        }
    }

    /// Checked once per appearance rather than continuously — a 14-day
    /// streak doesn't need to be detected mid-session, and this avoids
    /// re-evaluating on every unrelated state change.
    private func checkQuitDateProposal() {
        guard activeSheet == nil else { return }
        guard let plan, let target = plan.targetCigsPerDay, let setDate = plan.targetSetDate else { return }
        guard plan.quitDate == nil else { return }

        if let declinedAt = plan.quitDateDeclinedAt {
            let daysSinceDecline = Calendar.current.dateComponents([.day], from: declinedAt, to: Date()).day ?? 0
            guard daysSinceDecline >= 14 else { return }
        }

        let achieved = ReductionAchievement.hasMetGoalForTwoWeeks(
            smokedTimestamps: smokedLogs.map(\.timestamp),
            target: target,
            targetSetDate: setDate
        )
        if achieved {
            activeSheet = .quitDateProposal
        }
    }
}

private enum HomeSheet: Identifiable {
    case setGoal
    case quitDateProposal
    case quitDatePicker

    var id: Self { self }
}

#Preview {
    NavigationStack {
        HomeView(path: .constant([]))
    }
    .modelContainer(for: CravingLog.self, inMemory: true)
}
