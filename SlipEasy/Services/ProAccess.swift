//
//  ProAccess.swift
//  SlipEasy
//

import Foundation

enum ProAccess {
    @MainActor
    static var isUnlocked: Bool { StoreManager.shared.isPro }
}
