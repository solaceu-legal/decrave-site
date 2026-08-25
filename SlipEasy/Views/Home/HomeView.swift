//
//  HomeView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Binding var path: [AppRoute]

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

    @State private var activeSheet: HomeSheet?

    // Scales with Dynamic Type instead of a fixed point size, while still
    // starting well above the ≥72pt the design calls for.
    @ScaledMetric(relativeTo: .largeTitle) private var numberSize: CGFloat = 88

    var body: some View {
        // ScrollView + minHeight: centered at normal text sizes, scrolls
        // instead of squeezing/truncating content at max Dynamic Type
        // (see InterventionEndView — same pattern). Home didn't need this
        // before the reduction goal card added more content to the stack.
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 32) {
                    Spacer(minLength: 0)

                    VStack(spacing: 4) {
                        Text("\(beatenLogs.count)")
                            .font(.system(size: numberSize, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.primary)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                        Text(Strings.Home.cravingsBeaten)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }

                    if onboardingStatus != "A", plan?.quitDate == nil {
                        ReductionGoalCard(
                            plan: plan,
                            smokedLogs: smokedLogs,
                            onSetGoal: { activeSheet = .setGoal }
                        )
                    }

                    Spacer(minLength: 0)

                    Button {
                        path.append(.weeklyReport)
                    } label: {
                        VStack(spacing: 8) {
                            HStack(spacing: 4) {
                                Text(Strings.Home.last7Days)
                                Image(systemName: "chevron.right")
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            WeeklyBarsView(logs: beatenLogs)
                        }
                    }
                    .buttonStyle(.hapticPlain)

                    Spacer(minLength: 0)

                    VStack(spacing: 12) {
                        Button {
                            path.append(.toolPicker)
                        } label: {
                            Text("\(Strings.Home.wantToSmoke) 🔥")
                                .font(.headline)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.hapticProminent)
                        .controlSize(.large)

                        Button {
                            path.append(.log(outcome: .smoked))
                        } label: {
                            Text(Strings.Home.iSmoked)
                                .foregroundStyle(.secondary)
                        }
                        .buttonStyle(.hapticPlain)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                }
                .frame(minHeight: geometry.size.height)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    path.append(.settings)
                } label: {
                    Image(systemName: "gearshape")
                }
                .buttonStyle(.hapticPlain)
            }
        }
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
