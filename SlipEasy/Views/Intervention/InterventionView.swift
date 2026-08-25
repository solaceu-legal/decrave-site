//
//  InterventionView.swift
//  SlipEasy
//

import SwiftUI
import Combine

/// Runs either intervention tool (Urge Surfing or 4-7-8 Breathing) — the
/// phase list is the only thing that differs between them, so both share
/// this exact timer/progress mechanism.
/// Timing is wall-clock based (elapsed = now - phaseStart) so it stays
/// correct after the app is backgrounded or the screen locks.
struct InterventionView: View {
    let tool: InterventionTool
    @Binding var path: [AppRoute]

    private var phases: [InterventionPhase] { tool.phases }

    @State private var phaseIndex = 0
    @State private var phaseStart = Date()
    @State private var elapsedInPhase: Double = 0
    @State private var sessionStart = Date()
    @State private var isFinished = false

    // Manually connected (not .autoconnect()) so it can be cancelled
    // outright the moment the last phase ends — otherwise it keeps
    // ticking forever while the end screen sits on top, re-triggering
    // completion every 0.2s for as long as the user lingers there.
    //
    // Must be @State, not a plain `let`: InterventionView is a struct, so
    // SwiftUI reconstructs it (and re-runs every plain property
    // initializer) on nearly every body re-evaluation. A plain `let` here
    // would hand out a fresh, never-connected Timer.publish() instance on
    // each of those re-evaluations, while .connect() in onAppear only
    // ever ran once, on the very first instance. .onReceive would then be
    // listening to a different, uninitialized publisher than the one that
    // got connected — ticks silently go nowhere and the progress bar
    // never moves. This happened to surface right after a fresh install,
    // when CloudKit's initial export burst was triggering enough @Query
    // updates elsewhere to force extra re-evaluations right after
    // onAppear. @State's initializer only ever runs once per view
    // identity, so the same publisher instance is reused across every
    // re-evaluation and always matches what got connected.
    @State private var timerPublisher = Timer.publish(every: 0.2, on: .main, in: .common)
    @State private var timerConnection: Cancellable?

    var body: some View {
        Group {
            if isFinished {
                InterventionEndView(path: $path)
            } else {
                content
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            sessionStart = Date()
            phaseStart = Date()
            Analytics.trackInterventionStarted(toolType: tool.rawValue)
            timerConnection = timerPublisher.connect()
        }
        .onDisappear {
            stopTimer()
        }
        .onReceive(timerPublisher) { _ in
            tick()
        }
    }

    private var content: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                HStack {
                    Spacer()
                    Button(Strings.Intervention.exit, action: exitEarly)
                        .buttonStyle(.hapticPlain)
                        .foregroundStyle(.white.opacity(0.7))
                        .padding()
                }

                Spacer()

                Text(phases[phaseIndex].prompt)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Spacer()

                phaseProgressIndicator
                    .padding(.horizontal, 48)
                    .padding(.bottom, 48)
            }
        }
    }

    /// One segment per guidance phase — fills as that phase plays out,
    /// stays lit once it's done. No countdown numbers on purpose: a
    /// precise "0:47" implies the craving is scheduled to end when it
    /// hits zero, which is exactly the promise this exercise doesn't make.
    private var phaseProgressIndicator: some View {
        HStack(spacing: 6) {
            ForEach(phases.indices, id: \.self) { index in
                segmentBar(fraction: segmentFraction(for: index))
            }
        }
        .frame(height: 4)
    }

    private func segmentFraction(for index: Int) -> CGFloat {
        if index < phaseIndex { return 1 }
        if index > phaseIndex { return 0 }
        return CGFloat(min(elapsedInPhase / phases[index].duration, 1))
    }

    private func segmentBar(fraction: CGFloat) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule().fill(Color.white.opacity(0.25))
                Capsule()
                    .fill(Color.white)
                    .frame(width: geometry.size.width * fraction)
            }
        }
        .animation(.linear(duration: 0.2), value: fraction)
    }

    private func tick() {
        guard !isFinished else { return }
        elapsedInPhase = Date().timeIntervalSince(phaseStart)
        if elapsedInPhase >= phases[phaseIndex].duration {
            advancePhase()
        }
    }

    private func advancePhase() {
        if phaseIndex < phases.count - 1 {
            phaseIndex += 1
            phaseStart = Date()
            elapsedInPhase = 0
        } else {
            complete()
        }
    }

    /// Fires the moment the last phase ends — the only place
    /// intervention_completed(exitedEarly: false) is sent. The timer is
    /// stopped here first so no further tick can ever call this again,
    /// no matter how long the user lingers on the end screen after.
    private func complete() {
        stopTimer()
        let duration = Int(Date().timeIntervalSince(sessionStart))
        Analytics.trackInterventionCompleted(durationSec: duration, exitedEarly: false, toolType: tool.rawValue)
        isFinished = true
    }

    private func exitEarly() {
        stopTimer()
        let duration = Int(Date().timeIntervalSince(sessionStart))
        Analytics.trackInterventionCompleted(durationSec: duration, exitedEarly: true, toolType: tool.rawValue)
        path.removeAll()
    }

    private func stopTimer() {
        timerConnection?.cancel()
        timerConnection = nil
    }
}

#Preview {
    NavigationStack {
        InterventionView(tool: .urgeSurfing, path: .constant([]))
    }
}
