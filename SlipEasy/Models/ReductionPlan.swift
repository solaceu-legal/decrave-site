//
//  ReductionPlan.swift
//  SlipEasy
//

import Foundation
import SwiftData

/// The reduction ramp is an entry ramp toward a quit date, not a
/// destination of its own — see docs on the B/C onboarding split.
@Model
final class ReductionPlan {
    var targetCigsPerDay: Int?
    var targetSetDate: Date?
    var quitDate: Date?
    var quitDateDeclinedAt: Date?
    var id: UUID = UUID()

    init() {}
}
