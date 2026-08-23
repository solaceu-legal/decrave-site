//
//  LogView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

struct LogView: View {
    let outcome: CravingOutcome
    @Binding var path: [AppRoute]

    @Environment(\.modelContext) private var modelContext

    @Query(sort: \CravingLog.timestamp, order: .reverse)
    private var logsByRecency: [CravingLog]

    @State private var selectedTrigger: CravingTrigger?
    @State private var intensity: Double = 3
    @State private var isDraggingIntensity = false

    // Scales with Dynamic Type so chips stay one word per chip instead of
    // wrapping into unreadable narrow columns at accessibility sizes.
    @ScaledMetric(relativeTo: .body) private var chipMinWidth: CGFloat = 90

    private var columns: [GridItem] { [GridItem(.adaptive(minimum: chipMinWidth))] }

    var body: some View {
        // ScrollView so nothing on this screen truncates at large Dynamic
        // Type sizes — it also gives the title breathing room below the
        // status bar instead of a fixed top padding.
        ScrollView {
            VStack(spacing: 32) {
                Text(Strings.Log.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 24)

                VStack(alignment: .leading, spacing: 12) {
                    Text(Strings.Log.triggerQuestion)
                        .font(.headline)
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(CravingTrigger.allCases) { trigger in
                            triggerChip(trigger)
                        }
                    }
                    .sensoryFeedback(.selection, trigger: selectedTrigger)
                }
                .padding(.horizontal, 24)

                VStack(alignment: .leading, spacing: 12) {
                    Text(Strings.Log.intensityQuestion)
                        .font(.headline)
                    intensitySlider
                    HStack {
                        Text("1")
                        Spacer()
                        Text("5")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 24)

                Button(action: submit) {
                    Text(Strings.Log.submit)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.hapticProminent)
                .controlSize(.large)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // Bubble position is an approximation of the system slider thumb
    // (standard ~28pt thumb, so ~14pt radius inset on each end) — close
    // enough to track the thumb without a fully custom slider.
    private var intensitySlider: some View {
        GeometryReader { geometry in
            let thumbRadius: CGFloat = 14
            let fraction = (intensity - 1) / 4
            let trackWidth = geometry.size.width - thumbRadius * 2
            let bubbleX = thumbRadius + trackWidth * fraction

            ZStack(alignment: .topLeading) {
                Slider(
                    value: $intensity,
                    in: 1...5,
                    step: 1,
                    onEditingChanged: { editing in isDraggingIntensity = editing }
                )
                .sensoryFeedback(.selection, trigger: Int(intensity))
                .padding(.top, 28)

                if isDraggingIntensity {
                    Text("\(Int(intensity))")
                        .font(.caption.bold())
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.accentColor)
                        .clipShape(Capsule())
                        .offset(x: bubbleX - 12, y: 0)
                        .transition(.opacity.combined(with: .scale(scale: 0.7)))
                }
            }
        }
        .frame(height: 64)
        .animation(.easeOut(duration: 0.15), value: isDraggingIntensity)
    }

    private func triggerChip(_ trigger: CravingTrigger) -> some View {
        let isSelected = selectedTrigger == trigger
        return Button {
            selectedTrigger = isSelected ? nil : trigger
        } label: {
            Text(trigger.label)
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.accentColor : Color(.secondarySystemBackground))
                .foregroundStyle(isSelected ? Color.white : Color.primary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }

    private func submit() {
        let previousLog = logsByRecency.first

        let log = CravingLog()
        log.timestamp = Date()
        log.outcome = outcome
        log.trigger = selectedTrigger
        log.intensity = Int(intensity)
        modelContext.insert(log)

        if let previousLog, previousLog.outcome == .smoked {
            let hoursGap = log.timestamp.timeIntervalSince(previousLog.timestamp) / 3600
            Analytics.trackNextLogAfterSmoke(hoursGap: hoursGap)
        }

        switch outcome {
        case .beaten:
            Analytics.trackCravingLogged(trigger: selectedTrigger, intensity: Int(intensity))
            path.removeAll()
        case .smoked:
            Analytics.trackSmokedLogged(trigger: selectedTrigger, intensity: Int(intensity))
            path.append(.relapseConfirmation)
        }
    }
}

#Preview {
    NavigationStack {
        LogView(outcome: .beaten, path: .constant([]))
    }
    .modelContainer(for: CravingLog.self, inMemory: true)
}
