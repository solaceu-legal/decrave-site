//
//  ProProduct.swift
//  SlipEasy
//

import Foundation

enum ProProduct: String, CaseIterable {
    case monthly = "com.slipeasy.pro.monthly"
    case yearly = "com.slipeasy.pro.yearly"
    case lifetime = "com.slipeasy.pro.lifetime"

    // Only shown if a product's ASC display name fails to load.
    var fallbackLabel: String {
        switch self {
        case .monthly: "Monthly"
        case .yearly: "Yearly"
        case .lifetime: "Lifetime"
        }
    }
}
