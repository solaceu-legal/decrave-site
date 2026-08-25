//
//  AppRoute.swift
//  SlipEasy
//

import Foundation

enum AppRoute: Hashable {
    case toolPicker
    case intervention(tool: InterventionTool)
    case log(outcome: CravingOutcome)
    case relapseConfirmation
    case weeklyReport
    case settings
    case dataExport
}
