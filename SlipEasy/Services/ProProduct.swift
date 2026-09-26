//
//  ProProduct.swift
//  SlipEasy
//

import Foundation

enum ProProduct: String, CaseIterable {
    case monthly = "com.slipeasy.pro.monthly"
    case yearly = "com.slipeasy.pro.yearly"
    case lifetime = "com.slipeasy.pro.lifetime"

    // In-app language can differ from the App Store account's language.
    var fallbackLabel: String {
        switch self {
        case .monthly: Strings.Paywall.monthlyPlan
        case .yearly: Strings.Paywall.yearlyPlan
        case .lifetime: Strings.Paywall.lifetimePlan
        }
    }
}
