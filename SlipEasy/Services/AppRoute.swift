//
//  AppRoute.swift
//  SlipEasy
//

import Foundation

enum AppRoute: Hashable {
    case intervention(tool: InterventionTool)
    case toolbox
    case log(outcome: CravingOutcome, tool: InterventionTool?)
    case relapseConfirmation
    case dataExport
}
