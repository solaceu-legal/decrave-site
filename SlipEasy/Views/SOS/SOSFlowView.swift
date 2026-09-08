//
//  SOSFlowView.swift
//  SlipEasy
//
//  Hosts the entire craving-rescue flow behind the floating SOS button:
//  breathing (default) → optionally Urge Surfing → optionally the
//  toolbox → logging the outcome. Owns its own navigation stack so it's
//  independent of whichever tab was showing when it was opened.
//
//  Every screen inside still calls `path.removeAll()` to mean "I'm
//  done" (that convention predates this flow living in its own sheet —
//  see LogView, RelapseConfirmationView, InterventionView.exitEarly).
//  Rather than rewiring all of those, this view just treats path
//  going from non-empty back to empty as the signal to dismiss the
//  whole cover back to whichever tab was showing underneath.
//

import SwiftUI
import SwiftData

struct SOSFlowView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var path: [AppRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            InterventionView(tool: .breathing, path: $path)
                .navigationDestination(for: AppRoute.self) { route in
                    destination(for: route)
                }
        }
        .onChange(of: path) { old, new in
            if new.isEmpty && !old.isEmpty {
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
            LogView(outcome: outcome, tool: tool, path: $path)
        case .relapseConfirmation:
            RelapseConfirmationView(path: $path)
        case .dataExport:
            EmptyView() // unreachable — that route belongs to the You/Settings stack, not this flow
        }
    }
}

#Preview {
    SOSFlowView()
        .modelContainer(for: CravingLog.self, inMemory: true)
}
