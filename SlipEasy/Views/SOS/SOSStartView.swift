//
//  SOSStartView.swift
//  SlipEasy
//
//  The small decision point before a rescue session. It keeps the one-tap
//  path intact with a clear default, while letting people name the moment
//  first so the next recommendation can be specific to their own history.
//

import SwiftUI
import SwiftData

struct SOSStartView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var path: [AppRoute]
    @Binding var contextTrigger: CravingTrigger?

    @Query(sort: \CravingLog.timestamp)
    private var allLogs: [CravingLog]

    @AppStorage("preferredInterventionTool") private var preferredToolRaw = InterventionTool.breathing.rawValue
    @State private var selectedTrigger: CravingTrigger?
    @State private var defaultSaved = false

    private var summaries: [LogSummary] {
        allLogs.map {
            LogSummary(
                timestamp: $0.timestamp,
                outcome: $0.outcome,
                trigger: $0.trigger,
                usedIntervention: $0.interventionTool != nil,
                interventionTool: $0.interventionTool
            )
        }
    }

    private var preferredTool: InterventionTool {
        InterventionTool(rawValue: preferredToolRaw) ?? .breathing
    }

    private var recommendation: InsightsEngine.InterventionRecommendation? {
        // With no context selected yet, use the strongest overall pattern so
        // the first SOS screen can still offer a personal next move. Once a
        // context is chosen, the narrower trigger-specific pattern wins.
        if let selectedTrigger {
            return InsightsEngine.recommendedIntervention(for: selectedTrigger, in: summaries)
        }
        return InsightsEngine.recommendedIntervention(for: nil, in: summaries)
    }

    private var nextTool: InterventionTool {
        recommendation?.tool ?? preferredTool
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.appBackground.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    header
                    contextPicker
                    suggestionCard
                    toolChoices
                    toolboxLink
                }
                .padding(.horizontal, 24)
                // Leave the close control in the top corner and give the
                // title its own vertical breathing room. This keeps the
                // title centered instead of shifting it left to avoid the X.
                .padding(.top, 58)
                .padding(.bottom, 32)
            }

            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.semibold))
                    .frame(width: 36, height: 36)
                    .background(Color.cardFill, in: Circle())
                    .overlay(Circle().strokeBorder(Color.cardStroke, lineWidth: 1))
            }
            .foregroundStyle(.primary)
            .accessibilityLabel(Strings.Settings.close)
            .padding(.top, 8)
            .padding(.trailing, 20)
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            selectedTrigger = contextTrigger
        }
    }

    private var header: some View {
        VStack(spacing: 8) {
            Text(Strings.SOS.startTitle)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text(Strings.SOS.startSubtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    private var contextPicker: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(Strings.SOS.contextLabel)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 92), spacing: 8)], spacing: 8) {
                ForEach(CravingTrigger.allCases) { trigger in
                    Button {
                        selectedTrigger = selectedTrigger == trigger ? nil : trigger
                    } label: {
                        Text(trigger.label)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(selectedTrigger == trigger ? Color.accentColor : Color.cardFill)
                            .foregroundStyle(selectedTrigger == trigger ? Color.white : Color.primary)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }

            if selectedTrigger != nil {
                Button(Strings.SOS.contextLater) {
                    selectedTrigger = nil
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private var suggestionCard: some View {
        if let recommendation {
            VStack(alignment: .leading, spacing: 8) {
                Text(Strings.SOS.suggestedEyebrow)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.accentColor)
                Text(recommendation.tool.title)
                    .font(.headline)
                Text(Strings.SOS.suggestedBody(
                    tool: recommendation.tool.title,
                    beatenCount: recommendation.beatenCount,
                    attemptCount: recommendation.attemptCount
                ))
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(18)
            .cardStyle()
        } else {
            Text(Strings.SOS.noHistory)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(18)
                .cardStyle()
        }
    }

    private var toolChoices: some View {
        VStack(spacing: 10) {
            toolButton(nextTool, prominent: true)

            let alternate = nextTool == .breathing ? InterventionTool.urgeSurfing : .breathing
            toolButton(alternate, prominent: false)
        }
    }

    private func toolButton(_ tool: InterventionTool, prominent: Bool) -> some View {
        VStack(spacing: 4) {
            Button {
                start(tool)
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: tool.iconName)
                        .font(.title3)
                        .frame(width: 28)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(tool.title)
                            .font(.headline)
                        Text(tool.subtitle)
                            .font(.caption)
                            .foregroundStyle(prominent ? .white.opacity(0.8) : .secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(prominent ? AnyShapeStyle(LinearGradient.warm) : AnyShapeStyle(Color.cardFill))
                .foregroundStyle(prominent ? Color.white : Color.primary)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(prominent ? Color.clear : Color.cardStroke, lineWidth: 1)
                )
            }
            .buttonStyle(.plain)

            Button {
                preferredToolRaw = tool.rawValue
                defaultSaved = true
            } label: {
                Label(
                    preferredTool == tool ? Strings.SOS.defaultSaved : Strings.SOS.setAsDefault,
                    systemImage: preferredTool == tool ? "star.fill" : "star"
                )
                .font(.caption)
                .foregroundStyle(preferredTool == tool ? Color.gold : .secondary)
            }
            .buttonStyle(.plain)
        }
    }

    private var toolboxLink: some View {
        VStack(spacing: 6) {
            if defaultSaved {
                Text(Strings.SOS.defaultSaved)
                    .font(.caption)
                    .foregroundStyle(Color.gold)
            }
            Button {
                contextTrigger = selectedTrigger
                path.append(.toolbox)
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "arrow.uturn.forward")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(Color.coral)

                    Text(Strings.SOS.toolboxTitle)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary)

                    Spacer(minLength: 8)

                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
                .cardStyle(elevated: true)
            }
            .buttonStyle(.hapticPlain)
        }
        .padding(.top, 12)
    }

    private func start(_ tool: InterventionTool) {
        contextTrigger = selectedTrigger
        path.append(.intervention(tool: tool))
    }
}

#Preview {
    NavigationStack {
        SOSStartView(path: .constant([]), contextTrigger: .constant(nil))
    }
    .modelContainer(for: CravingLog.self, inMemory: true)
}
