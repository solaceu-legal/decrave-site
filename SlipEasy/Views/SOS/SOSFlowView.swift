//
//  SOSFlowView.swift
//  SlipEasy
//
//  Hosts the entire craving-rescue flow behind the floating SOS button:
//  context → recommended or saved tool → optionally the toolbox → logging
//  the outcome. Owns its own navigation stack so it's
//  independent of whichever tab was showing when it was opened.
//
//  Completed logging clears the route path to return to the tab underneath.
//  Leaving an exercise is different: it removes only that exercise route so
//  the SOS choice screen remains open.
//

import SwiftUI
import SwiftData

struct SOSFlowView: View {
    let initialTrigger: CravingTrigger?
    @Environment(\.dismiss) private var dismiss
    @State private var path: [AppRoute] = []
    @State private var contextTrigger: CravingTrigger?

    init(initialTrigger: CravingTrigger? = nil) {
        self.initialTrigger = initialTrigger
        _contextTrigger = State(initialValue: initialTrigger)
    }

    var body: some View {
        NavigationStack(path: $path) {
            SOSStartView(path: $path, contextTrigger: $contextTrigger)
                .navigationDestination(for: AppRoute.self) { route in
                    destination(for: route)
                }
        }
        .onChange(of: path) { old, new in
            let completedLogging = old.contains { route in
                switch route {
                case .log, .relapseConfirmation:
                    true
                default:
                    false
                }
            }
            if new.isEmpty && completedLogging {
                dismiss()
            }
        }
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .intervention(let tool):
            InterventionView(tool: tool, path: $path)
        case .toolbox:
            SOSToolboxView(path: $path)
        case .log(let outcome, let tool):
            LogView(outcome: outcome, tool: tool, path: $path, contextTrigger: $contextTrigger)
        case .relapseConfirmation:
            RelapseConfirmationView(path: $path)
        case .dataExport:
            EmptyView() // unreachable — that route belongs to the You/Settings stack, not this flow
        case .settings:
            EmptyView() // unreachable — settings belongs to the Progress navigation stack
        }
    }
}

#Preview {
    SOSFlowView()
        .modelContainer(for: CravingLog.self, inMemory: true)
}
