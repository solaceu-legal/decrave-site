//
//  SlipEasyApp.swift
//  SlipEasy
//
//  Created by 王晓航 on 2026/8/15.
//

import SwiftUI
import SwiftData

@main
struct SlipEasyApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @State private var hasTrackedColdStart = false

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CravingLog.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    init() {
        // Must happen here, not in an onAppear — TelemetryDeck needs to be
        // ready before the first view renders.
        Analytics.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(sharedModelContainer)
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                Analytics.trackAppOpened(isColdStart: !hasTrackedColdStart)
                hasTrackedColdStart = true
            }
        }
    }
}
