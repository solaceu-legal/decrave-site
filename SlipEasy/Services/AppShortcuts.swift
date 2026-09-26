//
//  AppShortcuts.swift
//  SlipEasy
//

import AppIntents

public struct StartSOSIntent: AppIntent {
    public static var title: LocalizedStringResource = "Start a Decrave SOS"
    public static var description = IntentDescription("Open the fastest path to a craving tool.")
    public static var openAppWhenRun: Bool { true }

    public init() {}

    public func perform() async throws -> some IntentResult {
        SOSLaunchRequest.request(source: .shortcut)
        return .result()
    }
}

public struct DecraveShortcuts: AppShortcutsProvider {
    @AppShortcutsBuilder
    public static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: StartSOSIntent(),
            phrases: [
                "Start an SOS in \(.applicationName)",
                "Open \(.applicationName) SOS"
            ],
            shortTitle: "SOS",
            systemImageName: "bolt.fill"
        )
    }
}
