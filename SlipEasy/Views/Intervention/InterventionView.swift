//
//  InterventionView.swift
//  SlipEasy
//

import SwiftUI

/// Runs either intervention tool (Urge Surfing or 4-7-8 Breathing) — both
/// share this exact phase-advance driver; only the phase list and the
/// per-tool visuals (BreathPacerView / UrgeAmbientView, and the progress
/// indicator style) differ.
/// Timing is wall-clock based (elapsed = now - phaseStart) so it stays
/// correct after the app is backgrounded or the screen locks.
struct InterventionView: View {
    let tool: InterventionTool
    @Binding var path: [AppRoute]

    // Only actually used when this view is the *root* of SOSFlowView's
    // NavigationStack (the default breathing screen) — see exitEarly().
    @Environment(\.dismiss) private var dismiss

    // Ever-increasing session counter, persisted. Read once per appearance
    // into `sessionVariantIndex` below — never read directly by `phases`,
    // otherwise a mid-session body re-evaluation after the counter has
    // already advanced would swap the prompt set out from under the user.
    @AppStorage("urgeSurfingVariantCounter") private var storedVariantIndex = 0
    @State private var sessionVariantIndex = 0

    private var phases: [InterventionPhase] { tool.phases(variantIndex: sessionVariantIndex) }

    @State private var phaseIndex = 0
    @State private var phaseStart = Date()
    @State private var sessionStart = Date()
    @State private var isFinished = false

    var body: some View {
        Group {
            if isFinished {
                InterventionEndView(tool: tool, path: $path)
            } else {
                content
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .sensoryFeedback(.selection, trigger: phaseIndex)
        .onAppear {
            sessionStart = Date()
            phaseStart = Date()
            sessionVariantIndex = storedVariantIndex
            storedVariantIndex += 1
            Analytics.trackInterventionStarted(toolType: tool.rawValue)
        }
    }

    private var content: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            // Ambient only — never tied to phase timing or framed as
            // representing craving intensity. Urge Surfing doesn't promise
            // the craving follows any curve, so nothing on screen should
            // look like it's charting one.
            if tool == .urgeSurfing {
                UrgeAmbientView()
            }

            VStack {
                HStack {
                    Spacer()
                    Button(Strings.Intervention.exit, action: exitEarly)
                        .buttonStyle(.hapticPlain)
                        .foregroundStyle(.white.opacity(0.7))
                        .padding()
                }

                Spacer()

                // breathAction is nil for every Urge Surfing phase, so this
                // only ever shows up for the breathing tool. BreathPacerView
                // drives its own scale animation off an internal
                // TimelineView(.animation) keyed on phaseStart, so it
                // doesn't need to sit inside a periodic timer here either.
                if let breathAction = phases[phaseIndex].breathAction {
                    BreathPacerView(action: breathAction, duration: phases[phaseIndex].duration, phaseStart: phaseStart)
                        .padding(.bottom, 32)
                }

                Text(phases[phaseIndex].prompt)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .contentTransition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: phaseIndex)

                Spacer()

                // TimelineView scoped tightly to just the progress
                // indicator (the one piece that needs live elapsed time)
                // and the tick that advances phaseIndex — not wrapped
                // around the whole screen. An earlier version put the
                // Exit button, breath pacer, and secondary actions inside
                // the periodic TimelineView too; rebuilding that whole
                // subtree 5x/second cancelled in-flight tap gestures on
                // Exit before they could complete, which is what made it
                // (and the other buttons here) unresponsive.
                TimelineView(.periodic(from: .now, by: 0.2)) { context in
                    InterventionProgressIndicator(tool: tool, phases: phases, phaseIndex: phaseIndex, elapsedInPhase: context.date.timeIntervalSince(phaseStart))
                        .onChange(of: context.date) { _, newDate in
                            tick(now: newDate)
                        }
                }
                .padding(.horizontal, 48)
                .padding(.bottom, 24)

                secondaryActions
                    .padding(.horizontal, 32)
                    .padding(.bottom, 48)
            }
        }
    }

    // Breathing offers a way to move straight into the more active tool,
    // or to end the session early if the urge has already passed — Urge
    // Surfing only offers a way out to the toolbox, since it's already
    // the more active tool. Neither replaces the automatic phase-timer
    // completion below; they're just earlier exits.
    @ViewBuilder
    private var secondaryActions: some View {
        switch tool {
        case .breathing:
            VStack(spacing: 14) {
                Button(action: rideTheUrge) {
                    Text(Strings.Intervention.rideTheUrge)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(LinearGradient.warm)
                        .clipShape(Capsule())
                }
                .buttonStyle(.hapticPlain)

                Button(Strings.Intervention.imFineNow, action: finishEarly)
                    .buttonStyle(.hapticPlain)
                    .foregroundStyle(.white.opacity(0.7))
            }
        case .urgeSurfing:
            Button(Strings.Intervention.stillHere, action: openToolbox)
                .buttonStyle(.hapticPlain)
                .foregroundStyle(.white.opacity(0.7))
        }
    }

    private func tick(now: Date) {
        guard !isFinished else { return }
        let elapsed = now.timeIntervalSince(phaseStart)
        if elapsed >= phases[phaseIndex].duration {
            advancePhase()
        }
    }

    private func advancePhase() {
        if phaseIndex < phases.count - 1 {
            phaseIndex += 1
            phaseStart = Date()
        } else {
            complete()
        }
    }

    /// Fires the moment the last phase ends — the only place
    /// intervention_completed(exitedEarly: false) is sent.
    private func complete() {
        let duration = Int(Date().timeIntervalSince(sessionStart))
        Analytics.trackInterventionCompleted(durationSec: duration, exitedEarly: false, toolType: tool.rawValue)
        isFinished = true
    }

    /// Skips straight to Urge Surfing without waiting out the rest of the
    /// breathing cycles — a deliberate early exit, distinct from
    /// `exitEarly()` (which abandons the flow) and `complete()` (which
    /// only ever fires when every phase finishes naturally).
    private func rideTheUrge() {
        let duration = Int(Date().timeIntervalSince(sessionStart))
        Analytics.trackInterventionCompleted(durationSec: duration, exitedEarly: true, toolType: tool.rawValue)
        path.append(.intervention(tool: .urgeSurfing))
    }

    /// Ends the session early because the craving has already eased,
    /// still routing through the same reflection screen as a natural
    /// completion — the ending experience shouldn't differ just because
    /// the user got there a few phases sooner.
    private func finishEarly() {
        let duration = Int(Date().timeIntervalSince(sessionStart))
        Analytics.trackInterventionCompleted(durationSec: duration, exitedEarly: true, toolType: tool.rawValue)
        isFinished = true
    }

    private func openToolbox() {
        path.append(.toolbox)
    }

    private func exitEarly() {
        let duration = Int(Date().timeIntervalSince(sessionStart))
        Analytics.trackInterventionCompleted(durationSec: duration, exitedEarly: true, toolType: tool.rawValue)
        // path.removeAll() only produces an observable change (which is
        // what SOSFlowView's onChange(of: path) watches for to dismiss
        // the cover) when path was non-empty — true for every *pushed*
        // screen in this flow. This view is also used as the flow's
        // NavigationStack root (the default breathing screen), where path
        // is already [] before this runs, so removeAll() is a no-op and
        // nothing dismisses. Guard that case with dismiss() directly.
        if path.isEmpty {
            dismiss()
        } else {
            path.removeAll()
        }
    }
}

#Preview {
    NavigationStack {
        InterventionView(tool: .urgeSurfing, path: .constant([]))
    }
}
