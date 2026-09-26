//
//  SOSLaunchRequest.swift
//  SlipEasy
//

import Foundation

extension Notification.Name {
    nonisolated static let decraveStartSOS = Notification.Name("decrave.startSOS")
}

enum SOSLaunchSource: String, Equatable {
    case button
    case dailyQuest
    case widget
    case shortcut
    case notification
}

enum SOSLaunchRequest {
    nonisolated static let pendingSourceKey = "pendingSOSLaunchSource"

    nonisolated static func request(source: SOSLaunchSource) {
        UserDefaults.standard.set(source.rawValue, forKey: pendingSourceKey)
        NotificationCenter.default.post(name: .decraveStartSOS, object: nil)
    }

    nonisolated static func consume() -> SOSLaunchSource? {
        guard let rawValue = UserDefaults.standard.string(forKey: pendingSourceKey),
              let source = SOSLaunchSource(rawValue: rawValue) else {
            return nil
        }
        UserDefaults.standard.removeObject(forKey: pendingSourceKey)
        return source
    }
}
