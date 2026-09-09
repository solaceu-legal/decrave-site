//
//  InsightsEngine.swift
//  SlipEasy
//
//  Pure logic, deliberately decoupled from SwiftData (see
//  ReductionAchievement.swift for the same pattern) — callers pass an
//  already date-windowed array (WeeklyReportView's existing "last 7 days"
//  filter), this just does the counting/thresholding.
//

import Foundation

struct LogSummary {
    let timestamp: Date
    let outcome: CravingOutcome
    let trigger: CravingTrigger?
    let usedIntervention: Bool
}

enum InsightsEngine {
    struct TriggerPatternInsight {
        let trigger: CravingTrigger
        let count: Int
    }

    struct InterventionEffectivenessInsight {
        let attemptCount: Int
        let beatenCount: Int
    }

    struct TriggerToolInsight {
        let trigger: CravingTrigger
        let attemptCount: Int
        let beatenCount: Int
    }

    struct TriggerBreakdown: Identifiable {
        let trigger: CravingTrigger
        let count: Int
        let percentage: Double // 0...1
        var id: String { trigger.rawValue }
    }

    // A single occurrence isn't a pattern — this avoids drawing a
    // conclusion from one data point in a short 7-day window.
    private static let minimumOccurrences = 2

    static func topSmokingTrigger(in logs: [LogSummary]) -> TriggerPatternInsight? {
        var counts: [CravingTrigger: Int] = [:]
        for log in logs where log.outcome == .smoked {
            guard let trigger = log.trigger else { continue }
            counts[trigger, default: 0] += 1
        }
        guard let top = counts.max(by: { $0.value < $1.value }), top.value >= minimumOccurrences else {
            return nil
        }
        return TriggerPatternInsight(trigger: top.key, count: top.value)
    }

    // Counts both outcomes — a trigger applies to the craving whether or
    // not it was beaten. Returns every trigger that showed up at least
    // once, ranked by count, rather than truncating to a fixed top-N.
    static func triggerBreakdown(in logs: [LogSummary]) -> [TriggerBreakdown] {
        var counts: [CravingTrigger: Int] = [:]
        for log in logs {
            guard let trigger = log.trigger else { continue }
            counts[trigger, default: 0] += 1
        }
        let total = counts.values.reduce(0, +)
        guard total > 0 else { return [] }
        return counts
            .map { TriggerBreakdown(trigger: $0.key, count: $0.value, percentage: Double($0.value) / Double(total)) }
            .sorted { $0.count > $1.count }
    }

    static func interventionEffectiveness(in logs: [LogSummary]) -> InterventionEffectivenessInsight? {
        let attempted = logs.filter(\.usedIntervention)
        guard attempted.count >= minimumOccurrences else { return nil }
        let beaten = attempted.filter { $0.outcome == .beaten }.count
        return InterventionEffectivenessInsight(attemptCount: attempted.count, beatenCount: beaten)
    }

    // Same two data points (trigger, tool effectiveness) crossed instead
    // of viewed separately — how well tools worked specifically for the
    // user's top trigger, not just overall. Still no conclusion drawn from
    // fewer than minimumOccurrences matching entries.
    static func triggerToolCrossReference(in logs: [LogSummary], topTrigger: CravingTrigger) -> TriggerToolInsight? {
        let matching = logs.filter { $0.trigger == topTrigger && $0.usedIntervention }
        guard matching.count >= minimumOccurrences else { return nil }
        let beaten = matching.filter { $0.outcome == .beaten }.count
        return TriggerToolInsight(trigger: topTrigger, attemptCount: matching.count, beatenCount: beaten)
    }

    // A simplified heuristic, not a validated psychological score. Starts
    // at a neutral midpoint so a brand-new account doesn't read as already
    // damaged, then replays every log in chronological order, clamping to
    // [momentumFloor, 100] after each one — so a slip always costs a felt
    // amount and a win always earns a felt amount back, no matter how long
    // the history is. Never below momentumFloor: directly guarantees the
    // Never-Reset Promise's "momentum bends, never breaks... zero is
    // impossible" (see Strings.Settings.promisePoint2Body). Replaying the
    // sorted history (rather than storing a running "current momentum")
    // keeps this a pure function of the log data — two devices that synced
    // the same logs in a different order via CloudKit still land on the
    // same number, instead of racing to overwrite each other's running
    // total.
    //
    // An earlier version computed this from lifetime totals directly
    // (baseline - min(smokedCount * 7, cap) + beatenCount * gain) — once
    // beatenCount got large enough (~27) the gain alone exceeded 100 even
    // at the smoking-loss cap, permanently pinning the score at 100 with
    // no further logging able to move it. Replaying with a per-step clamp
    // has no such ceiling: the score always has room to move because it's
    // never allowed to bank more than the visible range.
    private static let momentumBaseline = 50
    static let momentumFloor = 20
    private static let momentumLossPerSmoked = 7

    static func momentumScore(logs: [LogSummary]) -> Int {
        logs.sorted { $0.timestamp < $1.timestamp }.reduce(momentumBaseline) { score, log in
            let adjusted = score + (log.outcome == .beaten ? momentumGainPerBeaten : -momentumLossPerSmoked)
            return min(100, max(momentumFloor, adjusted))
        }
    }

    /// Points earned toward momentum for a single beaten craving — shown
    /// as the "+N" on the victory moment right after logging a win, kept
    /// in sync with the per-beaten gain used above.
    static let momentumGainPerBeaten = 3

    // 20/pack is the US/UK legal minimum — not a precise per-user figure,
    // but a reasonable approximation for cigarettes-per-pack.
    static func moneySaved(beatenCount: Int, pricePerPack: Double, cigarettesPerPack: Int = 20) -> Double {
        let pricePerCigarette = pricePerPack / Double(cigarettesPerPack)
        return pricePerCigarette * Double(beatenCount)
    }

    // Decrave's target market only: US, UK, Canada, Australia. A price
    // the user entered assuming one of these four should display in
    // that same currency, but a device set to some other region
    // shouldn't suddenly show, say, JPY against a price they meant in
    // dollars — USD is the safe fallback there.
    private static let supportedCurrencyCodes: Set<String> = ["USD", "GBP", "CAD", "AUD"]

    static var localizedCurrencyCode: String {
        guard let code = Locale.current.currency?.identifier, supportedCurrencyCodes.contains(code) else {
            return "USD"
        }
        return code
    }

    // Centralizes currency formatting so every money display follows the
    // device's own region — and, since the currency code now always
    // matches the locale, Foundation never needs to prefix it with a
    // disambiguator like "US$" or "CA$" the way it would showing USD
    // explicitly on a non-US device.
    static func formattedMoney(_ amount: Double) -> String {
        amount.formatted(.currency(code: localizedCurrencyCode))
    }

    private static let currencySymbols: [String: String] = ["USD": "$", "GBP": "£", "CAD": "$", "AUD": "$"]

    // Bare symbol, never a "US$"/"CA$"-style disambiguation prefix —
    // for the Home hero number specifically, which sits beside cravings
    // beaten in a fixed-width column (see HomeView.heroStat). A never-
    // resets total will keep growing digits over months of use, and the
    // prefix is exactly the few extra characters that would eventually
    // force a wrap there. formattedMoney(_:) above (with its fuller,
    // occasionally-disambiguated form) is still correct everywhere else.
    static func formattedMoneyCompact(_ amount: Double) -> String {
        let symbol = currencySymbols[localizedCurrencyCode] ?? "$"
        return symbol + amount.formatted(.number.precision(.fractionLength(2)))
    }

    struct PredictedWindow {
        let weekday: Int // Calendar weekday: 1 = Sunday ... 7 = Saturday
        let hour: Int // 0-23
        let trigger: CravingTrigger?
        let occurrences: Int

        // Shared by the Home preview card and the Insights detail card so
        // the two never drift into slightly different phrasing.
        var weekdayName: String {
            let symbols = Calendar.current.weekdaySymbols
            guard weekday >= 1, weekday <= symbols.count else { return "" }
            return symbols[weekday - 1] + "s"
        }

        var formattedHour: String {
            var components = DateComponents()
            components.hour = hour
            let date = Calendar.current.date(from: components) ?? Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "h a"
            return formatter.string(from: date)
        }
    }

    // A stricter bar than the pattern insights above (3, not 2) — this is
    // read as a prediction of what's coming, not just a note about what
    // already happened, so it should take slightly more evidence to earn
    // that framing. Buckets every log (beaten and smoked alike) by
    // weekday+hour, since the question is "when do cravings tend to show
    // up at all," not just "when do they win."
    private static let minimumWindowOccurrences = 3

    static func predictedCravingWindow(logs: [LogSummary]) -> PredictedWindow? {
        let calendar = Calendar.current
        var buckets: [DateComponents: [CravingTrigger?]] = [:]
        for log in logs {
            let comps = calendar.dateComponents([.weekday, .hour], from: log.timestamp)
            buckets[comps, default: []].append(log.trigger)
        }
        guard let topBucket = buckets.max(by: { $0.value.count < $1.value.count }),
              topBucket.value.count >= minimumWindowOccurrences,
              let weekday = topBucket.key.weekday,
              let hour = topBucket.key.hour else {
            return nil
        }
        var triggerCounts: [CravingTrigger: Int] = [:]
        for trigger in topBucket.value.compactMap({ $0 }) {
            triggerCounts[trigger, default: 0] += 1
        }
        let topTrigger = triggerCounts.max(by: { $0.value < $1.value })?.key
        return PredictedWindow(weekday: weekday, hour: hour, trigger: topTrigger, occurrences: topBucket.value.count)
    }

    struct MoneyTrajectoryPoint: Identifiable {
        let month: Int // 0 = now
        let cumulativeSaved: Double
        var id: Int { month }
    }

    // Projects forward at the user's recent (last-7-days) pace, not their
    // all-time average — someone who just started beating cravings this
    // week should see that reflected sooner than an all-time blend would
    // show it. A silent week means a flat line, not a shrinking one; this
    // never projects backward or down.
    static func moneyTrajectory(currentSaved: Double, perWeekSavings: Double, months: Int = 12) -> [MoneyTrajectoryPoint] {
        let weeksPerMonth = 4.345
        return (0...months).map { month in
            MoneyTrajectoryPoint(month: month, cumulativeSaved: currentSaved + perWeekSavings * weeksPerMonth * Double(month))
        }
    }
}
