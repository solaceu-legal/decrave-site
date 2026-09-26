//
//  TodaysQuestCard.swift
//  SlipEasy
//
//  A small rotating daily quest matching Decrave's Home "Today's quest"
//  module. Each assignment points to a real action and stays stable for
//  the calendar day; completion comes from today's craving logs rather than
//  from tapping the button alone.
//

import SwiftUI
import SwiftData

struct TodaysQuestCard: View {
    var onStartQuest: (CravingTrigger?) -> Void

    @Query(sort: \CravingLog.timestamp, order: .reverse)
    private var logs: [CravingLog]

    @AppStorage("dailyQuestAssignedDate") private var assignedDate = ""
    @AppStorage("dailyQuestKind") private var assignedKindRaw = ""
    @AppStorage("dailyQuestTrigger") private var assignedTriggerRaw = ""
    @AppStorage("dailyQuestActionCount") private var actionCount = 0
    @AppStorage("dailyQuestLastCompletedKey") private var lastCompletedKey = ""

    private static var todayKey: String {
        DailyQuestEngine.dayKey(for: Date())
    }

    private var startOfToday: Date {
        Calendar.current.startOfDay(for: Date())
    }

    private var quest: DailyQuest {
        let kind: DailyQuestKind
        let trigger: CravingTrigger?

        if assignedDate == Self.todayKey, let assignedKind = DailyQuestKind(rawValue: assignedKindRaw) {
            kind = assignedKind
            trigger = CravingTrigger(rawValue: assignedTriggerRaw)
        } else {
            kind = DailyQuestEngine.defaultKind(for: Date())
            trigger = kind == .nameTrigger ? DailyQuestEngine.relevantTrigger(in: logs) : nil
        }

        return DailyQuest(kind: kind, trigger: trigger)
    }

    private var isCompleted: Bool {
        DailyQuestEngine.isCompleted(quest, in: logs, since: startOfToday)
    }

    private var questCompletionKey: String {
        "\(Self.todayKey):\(quest.id)"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.Home.questEyebrow)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(Color.violet)

            Text(quest.title)
                .font(.headline)
                .foregroundStyle(.primary)

            Text(quest.body)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                Text(Strings.Home.questActionTag)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(Color.accentColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.accentColor.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))

                Spacer()

                Button(action: startQuest) {
                    Text(isCompleted ? Strings.Home.questCompleted : quest.actionTitle)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(isCompleted ? .secondary : .primary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Color.cardFillElevated)
                        .clipShape(Capsule())
                }
                .buttonStyle(.hapticPlain)
                .disabled(isCompleted)
            }
            .padding(.top, 4)

            if actionCount > 0 {
                Text(Strings.Home.questActionsBanked(actionCount))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .cardStyle()
        .onAppear {
            assignQuestIfNeeded()
            recordCompletionIfNeeded()
            syncWidgetState()
        }
        .onChange(of: logs.count) { _, _ in
            recordCompletionIfNeeded()
            syncWidgetState()
        }
    }

    private func assignQuestIfNeeded() {
        guard assignedDate != Self.todayKey || DailyQuestKind(rawValue: assignedKindRaw) == nil else { return }

        let kind = DailyQuestEngine.defaultKind(for: Date())
        assignedDate = Self.todayKey
        assignedKindRaw = kind.rawValue
        assignedTriggerRaw = kind == .nameTrigger
            ? (DailyQuestEngine.relevantTrigger(in: logs)?.rawValue ?? "")
            : ""
    }

    private func recordCompletionIfNeeded() {
        guard isCompleted, lastCompletedKey != questCompletionKey else { return }
        lastCompletedKey = questCompletionKey
        actionCount += 1
    }

    private func startQuest() {
        onStartQuest(quest.trigger)
    }

    private func syncWidgetState() {
        WidgetSyncService.sync(quest: quest, isCompleted: isCompleted, logs: logs)
    }
}

#Preview {
    VStack(spacing: 12) {
        TodaysQuestCard(onStartQuest: { _ in })
    }
    .padding()
    .background(Color.appBackground)
    .modelContainer(for: CravingLog.self, inMemory: true)
}
