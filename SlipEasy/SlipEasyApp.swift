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
            ReductionPlan.self,
        ])

        // .automatic reads the CloudKit container ID from the app's
        // entitlements, so nothing here needs to name it explicitly.
        let cloudConfig = ModelConfiguration(schema: schema, cloudKitDatabase: .automatic)
        if let container = try? ModelContainer(for: schema, configurations: [cloudConfig]) {
            return container
        }

        // CloudKit init can fail for reasons unrelated to "no iCloud
        // account signed in" (that path is handled internally by
        // SwiftData/CloudKit — local reads/writes keep working, sync just
        // sits idle). This is the fallback for when container creation
        // itself throws, so a CloudKit hiccup never blocks the app from
        // opening.
        let localConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        guard let fallback = try? ModelContainer(for: schema, configurations: [localConfiguration]) else {
            fatalError("Could not create ModelContainer even in local-only mode")
        }
        return fallback
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
