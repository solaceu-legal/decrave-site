//
//  InterventionView.swift
//  SlipEasy
//

import SwiftUI
import Combine

/// Urge Surfing — the only intervention tool in v0.1.
/// Timing is wall-clock based (elapsed = now - phaseStart) so it stays
/// correct after the app is backgrounded or the screen locks.
struct InterventionView: View {
    @Binding var path: [AppRoute]

    private let phaseDurations: [Double] = [20, 40, 60, 60]
    private let phasePrompts = [
        Strings.Intervention.phase1Prompt,
        Strings.Intervention.phase2Prompt,
        Strings.Intervention.phase3Prompt,
        Strings.Intervention.phase4Prompt
    ]

    @State private var phaseIndex = 0
    @State private var phaseStart = Date()
    @State private var elapsedInPhase: Double = 0
    @State private var sessionStart = Date()
    @State private var isFinished = false

    // Manually connected (not .autoconnect()) so it can be cancelled
    // outright the moment the last phase ends — otherwise it keeps
    // ticking forever while the end screen sits on top, re-triggering
    // completion every 0.2s for as long as the user lingers there.
    private let timerPublisher = Timer.publish(every: 0.2, on: .main, in: .common)
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
            Analytics.trackInterventionStarted()
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

                Text(phasePrompts[phaseIndex])
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
            ForEach(phaseDurations.indices, id: \.self) { index in
                segmentBar(fraction: segmentFraction(for: index))
            }
        }
        .frame(height: 4)
    }

    private func segmentFraction(for index: Int) -> CGFloat {
        if index < phaseIndex { return 1 }
        if index > phaseIndex { return 0 }
        return CGFloat(min(elapsedInPhase / phaseDurations[index], 1))
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
        if elapsedInPhase >= phaseDurations[phaseIndex] {
            advancePhase()
        }
    }

    private func advancePhase() {
        if phaseIndex < phaseDurations.count - 1 {
            phaseIndex += 1
            phaseStart = Date()
            elapsedInPhase = 0
        } else {
            complete()
        }
    }

    /// Fires the moment the last phase ends (180s) — the only place
    /// intervention_completed(exitedEarly: false) is sent. The timer is
    /// stopped here first so no further tick can ever call this again,
    /// no matter how long the user lingers on the end screen after.
    private func complete() {
        stopTimer()
        let duration = Int(Date().timeIntervalSince(sessionStart))
        Analytics.trackInterventionCompleted(durationSec: duration, exitedEarly: false)
        isFinished = true
    }

    private func exitEarly() {
        stopTimer()
        let duration = Int(Date().timeIntervalSince(sessionStart))
        Analytics.trackInterventionCompleted(durationSec: duration, exitedEarly: true)
        path.removeAll()
    }

    private func stopTimer() {
        timerConnection?.cancel()
        timerConnection = nil
    }
}

#Preview {
    NavigationStack {
        InterventionView(path: .constant([]))
    }
}
