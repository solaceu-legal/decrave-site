//
//  ReductionAchievement.swift
//  SlipEasy
//
//  Pure logic, deliberately decoupled from SwiftData/SwiftUI so it can be
//  verified directly without a test target or waiting on real calendar days.
//

import Foundation

enum ReductionAchievement {
    /// True when every one of the 14 most recently *completed* days (today
    /// doesn't count — it isn't over yet) had a smoked count at or under
    /// target, and the target was already active before that window began
    /// (otherwise changing the target today could retroactively "achieve"
    /// a streak that never happened under it).
    static func hasMetGoalForTwoWeeks(
        smokedTimestamps: [Date],
        target: Int,
        targetSetDate: Date,
        referenceDate: Date = Date(),
        calendar: Calendar = .current
    ) -> Bool {
        let today = calendar.startOfDay(for: referenceDate)
        guard let windowStart = calendar.date(byAdding: .day, value: -14, to: today) else {
            return false
        }
        guard targetSetDate <= windowStart else { return false }

        for offset in 1...14 {
            guard let day = calendar.date(byAdding: .day, value: -offset, to: today) else {
                return false
            }
            let count = smokedTimestamps.filter { calendar.isDate($0, inSameDayAs: day) }.count
            if count > target { return false }
        }
        return true
    }
}
