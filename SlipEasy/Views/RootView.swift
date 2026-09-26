//
//  RootView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData
import Foundation

struct RootView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage(AppLanguage.storageKey) private var appLanguageCode = AppLanguage.english.rawValue
    @Environment(\.scenePhase) private var scenePhase
    @State private var requestedSOSSource: SOSLaunchSource?

    private var appLanguage: AppLanguage {
        AppLanguage(rawValue: appLanguageCode) ?? .system
    }

    var body: some View {
        Group {
            if hasCompletedOnboarding {
                MainFlowView(requestedSOSSource: $requestedSOSSource)
            } else {
                OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
            }
        }
        .environment(\.locale, appLanguage.locale)
        .onOpenURL { url in
            guard url.scheme == "decrave", url.host == "sos" else { return }
            let sourceValue = URLComponents(url: url, resolvingAgainstBaseURL: false)?
                .queryItems?
                .first(where: { $0.name == "source" })?
                .value
            requestedSOSSource = sourceValue.flatMap(SOSLaunchSource.init(rawValue:)) ?? .widget
        }
        .onAppear {
            consumePendingShortcut()
        }
        .onReceive(NotificationCenter.default.publisher(for: .decraveStartSOS)) { _ in
            requestedSOSSource = .shortcut
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                consumePendingShortcut()
            }
        }
    }

    private func consumePendingShortcut() {
        guard let source = SOSLaunchRequest.consume() else { return }
        requestedSOSSource = source
    }
}

#Preview {
    RootView()
        .modelContainer(for: CravingLog.self, inMemory: true)
}
