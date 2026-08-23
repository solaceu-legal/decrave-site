//
//  AppRoute.swift
//  SlipEasy
//

import Foundation

enum AppRoute: Hashable {
    case intervention
    case log(outcome: CravingOutcome)
    case relapseConfirmation
}
