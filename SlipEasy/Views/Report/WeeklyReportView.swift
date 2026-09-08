//
//  WeeklyReportView.swift
//  SlipEasy
//
//  Free tier gets Craving intensity, Top triggers, Money trajectory, and
//  Milestones; the interpretive/predictive layer (pattern insights,
//  Trigger Radar detail) is Pro. Each Pro section gates itself
//  individually via ProLockedSection rather than the whole page going
//  behind one lock (see DataExportView for the page-level equivalent,
//  still appropriate there since it's a single all-or-nothing feature).
//

import SwiftUI
import SwiftData

struct WeeklyReportView: View {
    @Query(sort: \CravingLog.timestamp) private var allLogs: [CravingLog]
    @AppStorage("pricePerPack") private var pricePerPack: Double = 8.5

    // Same "last 7 days including today" window as WeeklyBarsView on Home,
    // computed the same way (filter in Swift, not a dynamic SwiftData
    // predicate) for consistency with the rest of the app.
    private var weekLogs: [CravingLog] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        guard let windowStart = calendar.date(byAdding: .day, value: -6, to: today) else { return [] }
        return allLogs.filter { $0.timestamp >= windowStart }
    }

    private var winsThisWeek: Int {
        weekLogs.filter { $0.outcome == .beaten }.count
    }

    private var allTimeBeatenCount: Int {
        allLogs.filter { $0.outcome == .beaten }.count
    }

    private var weekLogSummaries: [LogSummary] {
        weekLogs.map { LogSummary(timestamp: $0.timestamp, outcome: $0.outcome, trigger: $0.trigger, usedIntervention: $0.interventionTool != nil) }
    }

    private var allLogSummaries: [LogSummary] {
        allLogs.map { LogSummary(timestamp: $0.timestamp, outcome: $0.outcome, trigger: $0.trigger, usedIntervention: $0.interventionTool != nil) }
    }

    private var triggerInsight: InsightsEngine.TriggerPatternInsight? {
        InsightsEngine.topSmokingTrigger(in: weekLogSummaries)
    }

    private var toolInsight: InsightsEngine.InterventionEffectivenessInsight? {
        InsightsEngine.interventionEffectiveness(in: weekLogSummaries)
    }

    private var triggerBreakdown: [InsightsEngine.TriggerBreakdown] {
        InsightsEngine.triggerBreakdown(in: weekLogSummaries)
    }

    // Deliberately the same weekLogSummaries (not all-time) — the card's
    // headline already says "in the past 7 days"; drawing the suggestion
    // from a different, wider window than the stat above it would make
    // the card internally inconsistent. This will fire less often while
    // intervention-tool data is still thin, and that's fine — it should
    // only speak up once it has enough same-window evidence.
    private var triggerToolInsight: InsightsEngine.TriggerToolInsight? {
        guard let triggerInsight else { return nil }
        return InsightsEngine.triggerToolCrossReference(in: weekLogSummaries, topTrigger: triggerInsight.trigger)
    }

    // Trigger Radar looks across all history, not just this week — a
    // weekday+hour pattern needs more than 7 days of data to mean anything.
    private var prediction: InsightsEngine.PredictedWindow? {
        InsightsEngine.predictedCravingWindow(logs: allLogSummaries)
    }

    private var moneySavedTotal: Double {
        InsightsEngine.moneySaved(beatenCount: allTimeBeatenCount, pricePerPack: pricePerPack)
    }

    private var trajectoryPoints: [InsightsEngine.MoneyTrajectoryPoint] {
        let perWeekSavings = InsightsEngine.moneySaved(beatenCount: winsThisWeek, pricePerPack: pricePerPack)
        return InsightsEngine.moneyTrajectory(currentSaved: moneySavedTotal, perWeekSavings: perWeekSavings)
    }

    var body: some View {
        ScrollView {
            // Free charts first (Craving intensity → Top triggers → Money
            // trajectory → Milestones), locked previews last — mirrors
            // Decrave's own Insights page order.
            VStack(alignment: .leading, spacing: 24) {
                Text(Strings.Report.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                freeSectionCard(eyebrow: Strings.Report.cravingIntensityEyebrow) {
                    cravingIntensitySection
                }

                freeSectionCard(eyebrow: Strings.Report.topTriggersEyebrow) {
                    TopTriggersRows(breakdown: triggerBreakdown)
                }

                freeSectionCard(eyebrow: Strings.Report.moneyTrajectoryTitle) {
                    moneyTrajectorySection
                }

                sectionCard(title: Strings.Report.milestonesTitle) {
                    MilestonesRow(beatenCount: allTimeBeatenCount)
                }

                ProLockedSection(unlockLabel: Strings.Report.unlockInsightsCTA) {
                    insightsSection
                }

                ProLockedSection(unlockLabel: Strings.Report.unlockRadarCTA) {
                    triggerRadarDetail
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, Layout.tabBarClearance)
        }
        .background(Color.appBackground.ignoresSafeArea())
    }

    private func sectionCard<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .cardStyle()
    }

    // Lighter-weight header than sectionCard's bold .headline title — a
    // small secondary-colored eyebrow, matching Decrave's own (uncolored)
    // Insights-page card headers. Home's cards tint this per-module;
    // Insights keeps it neutral the way the reference design does.
    private func freeSectionCard<Content: View>(eyebrow: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(eyebrow)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .cardStyle()
    }

    @ViewBuilder
    private var cravingIntensitySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(Strings.Report.cravingIntensityTitle)
                .font(.headline)
            // allLogs, not weekLogs — the chart buckets by a fixed
            // Monday–Sunday calendar week itself; weekLogs' rolling
            // window would cut off or misattribute days once relabeled.
            CravingIntensityChart(logs: allLogs)
            // Reuses the same all-time weekday+hour prediction as Trigger
            // Radar rather than computing a separate multi-day range —
            // one honest pattern, not two slightly different ones.
            if let prediction {
                Text(Strings.Report.peakWindowCaption(weekday: prediction.weekdayName, hour: prediction.formattedHour))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    @ViewBuilder
    private var insightsSection: some View {
        if triggerInsight == nil && toolInsight == nil {
            Text(Strings.Report.notEnoughData)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        } else {
            VStack(spacing: 12) {
                if let toolInsight {
                    InsightCard(
                        icon: "checkmark.seal.fill",
                        title: Strings.Insights.toolEffectivenessTitle,
                        message: Strings.Insights.toolEffectivenessBody(
                            attemptCount: toolInsight.attemptCount,
                            beatenCount: toolInsight.beatenCount
                        )
                    )
                }
                if let triggerInsight {
                    InsightCard(
                        icon: "lightbulb.fill",
                        title: Strings.Insights.triggerPatternTitle,
                        message: Strings.Insights.triggerPatternBody(
                            trigger: triggerInsight.trigger,
                            count: triggerInsight.count
                        ),
                        suggestion: triggerSuggestion(for: triggerInsight)
                    )
                }
            }
        }
    }

    @ViewBuilder
    private var triggerRadarDetail: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.Report.triggerRadarDetailTitle)
                .font(.headline)
            if let prediction {
                Text(radarText(for: prediction))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(Strings.Report.triggerRadarDetailBody(occurrences: prediction.occurrences))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                Text(Strings.Report.triggerRadarNotEnoughData)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var moneyTrajectorySection: some View {
        // No title Text here — freeSectionCard's eyebrow (moneyTrajectoryTitle)
        // already labels this card, see body.
        VStack(alignment: .leading, spacing: 8) {
            MoneyTrajectoryChart(points: trajectoryPoints)
            if let lastPoint = trajectoryPoints.last {
                Text(Strings.Report.moneyTrajectoryCaption(lastPoint.cumulativeSaved.formatted(.currency(code: "USD"))))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func radarText(for window: InsightsEngine.PredictedWindow) -> String {
        if let trigger = window.trigger {
            return Strings.Home.triggerRadarPreview(weekday: window.weekdayName, hour: window.formattedHour, trigger: trigger.label.lowercased())
        }
        return Strings.Home.triggerRadarPreview(weekday: window.weekdayName, hour: window.formattedHour)
    }

    private func triggerSuggestion(for insight: InsightsEngine.TriggerPatternInsight) -> String {
        if let triggerToolInsight {
            return Strings.Insights.triggerToolSuggestion(
                attemptCount: triggerToolInsight.attemptCount,
                beatenCount: triggerToolInsight.beatenCount
            )
        }
        return Strings.Insights.triggerSuggestion(insight.trigger)
    }
}

#Preview {
    NavigationStack {
        WeeklyReportView()
    }
    .modelContainer(for: CravingLog.self, inMemory: true)
}
