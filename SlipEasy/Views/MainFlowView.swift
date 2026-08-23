//
//  MainFlowView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

struct MainFlowView: View {
    @State private var path: [AppRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .intervention:
                        InterventionView(path: $path)
                    case .log(let outcome):
                        LogView(outcome: outcome, path: $path)
                    case .relapseConfirmation:
                        RelapseConfirmationView(path: $path)
                    }
                }
        }
    }
}

#Preview {
    MainFlowView()
        .modelContainer(for: CravingLog.self, inMemory: true)
}
