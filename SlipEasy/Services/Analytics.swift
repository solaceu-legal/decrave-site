//
//  Analytics.swift
//  SlipEasy
//
//  Single entry point for the 8 events in docs/SlipEasy-14天薄版本-功能清单与启动方案.md §3.
//

import Foundation
import TelemetryDeck
import os

enum Analytics {
    private static let debugLogger = Logger(subsystem: "com.slipeasy.SlipEasy", category: "Analytics")

    // Get this from the TelemetryDeck Dashboard → your app → "Set Up App".
    // Not a secret — it's a routing ID meant to ship inside the app binary.
    private static let appID = "97E73DC7-5CEE-435E-BF7B-66A597265AA9"

    private enum Keys {
        static let lastOpenedAt = "analytics_lastOpenedAt"
        static let firstOpenedAt = "analytics_firstOpenedAt"
        static let lastActiveDayTracked = "analytics_lastActiveDayTracked"
    }

    /// Call once, from SlipEasyApp.init() — not from a View's onAppear.
    static func configure() {
        let config = TelemetryDeck.Config(appID: appID)
        TelemetryDeck.initialize(config: config)
    }

    // MARK: - Events

    static func trackOnboardingCompleted(status: String, cigsPerDay: Int) {
        track("onboarding_completed", [
            "status": status,
            "cigs_per_day": String(cigsPerDay)
        ])
    }

    /// Call from scenePhase becoming .active. Also fires day_n_active
    /// (at most once per calendar day) as a side effect.
    static func trackAppOpened(isColdStart: Bool) {
        let defaults = UserDefaults.standard
        let now = Date()
        let lastOpened = defaults.object(forKey: Keys.lastOpenedAt) as? Date

        var params: [String: String] = ["is_cold_start": String(isColdStart)]
        if let lastOpened {
            let hours = now.timeIntervalSince(lastOpened) / 3600
            params["hours_since_last"] = String(format: "%.2f", hours)
        }
        track("app_opened", params)

        defaults.set(now, forKey: Keys.lastOpenedAt)
        trackDayNActiveIfNeeded(now: now, defaults: defaults)
    }

    static func trackInterventionStarted(toolType: String) {
        track("intervention_started", ["tool_type": toolType])
    }

    static func trackInterventionCompleted(durationSec: Int, exitedEarly: Bool, toolType: String) {
        track("intervention_completed", [
            "duration_sec": String(durationSec),
            "exited_early": String(exitedEarly),
            "tool_type": toolType
        ])
    }

    static func trackCravingLogged(trigger: CravingTrigger?, intensity: Int) {
        track("craving_logged", [
            "outcome": CravingOutcome.beaten.rawValue,
            "trigger": trigger?.rawValue ?? "",
            "intensity": String(intensity)
        ])
    }

    static func trackSmokedLogged(trigger: CravingTrigger?, intensity: Int) {
        track("smoked_logged", [
            "trigger": trigger?.rawValue ?? "",
            "intensity": String(intensity)
        ])
    }

    /// Fired when the next log (of either outcome) arrives after a smoked
    /// log — this is what answers "do they come back after a slip".
    static func trackNextLogAfterSmoke(hoursGap: Double) {
        track("next_log_after_smoke", [
            "hours_gap": String(format: "%.2f", hoursGap)
        ])
    }

    // MARK: - Internals

    private static func trackDayNActiveIfNeeded(now: Date, defaults: UserDefaults) {
        let calendar = Calendar.current

        let firstOpenedAt: Date
        if let stored = defaults.object(forKey: Keys.firstOpenedAt) as? Date {
            firstOpenedAt = stored
        } else {
            firstOpenedAt = now
            defaults.set(now, forKey: Keys.firstOpenedAt)
        }

        if let lastTrackedDay = defaults.object(forKey: Keys.lastActiveDayTracked) as? Date,
           calendar.isDate(lastTrackedDay, inSameDayAs: now) {
            return
        }

        let n = calendar.dateComponents(
            [.day],
            from: calendar.startOfDay(for: firstOpenedAt),
            to: calendar.startOfDay(for: now)
        ).day ?? 0

        track("day_n_active", ["n": String(n)])
        defaults.set(now, forKey: Keys.lastActiveDayTracked)
    }

    private static func track(_ event: String, _ parameters: [String: String] = [:]) {
        #if DEBUG
        debugLogger.debug("\(event, privacy: .public) \(parameters.description, privacy: .public)")
        #endif
        TelemetryDeck.signal(event, parameters: parameters)
    }
}
