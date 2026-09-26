//
//  DecraveWidget.swift
//  DecraveWidget
//

import SwiftUI
import WidgetKit

private let sosURL = URL(string: "decrave://sos")!

private extension Color {
    static let widgetBackground = Color(red: 0.027, green: 0.043, blue: 0.067)
    static let widgetCoral = Color(red: 1.0, green: 0.478, blue: 0.349)
    static let widgetGold = Color(red: 1.0, green: 0.788, blue: 0.42)
    static let widgetViolet = Color(red: 0.612, green: 0.549, blue: 1.0)
}

struct DecraveWidgetEntry: TimelineEntry {
    let date: Date
    let questKindRaw: String
    let questTitle: String
    let questBody: String
    let isCompleted: Bool
    let radarWeekday: Int?
    let radarHour: Int?
    let radarTriggerRaw: String?
    let radarTriggerLabel: String?
    let radarOccurrences: Int?
}

struct DecraveWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> DecraveWidgetEntry {
        DecraveWidgetEntry(
            date: Date(),
            questKindRaw: "practice_tool",
            questTitle: "Practice your usual SOS",
            questBody: "One short intervention before you need it.",
            isCompleted: false,
            radarWeekday: nil,
            radarHour: nil,
            radarTriggerRaw: nil,
            radarTriggerLabel: nil,
            radarOccurrences: nil
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (DecraveWidgetEntry) -> Void) {
        completion(entry(for: Date(), sharedState: WidgetSharedStore.load()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<DecraveWidgetEntry>) -> Void) {
        let calendar = Calendar.current
        let now = Date()
        let startOfToday = calendar.startOfDay(for: now)
        let sharedState = WidgetSharedStore.load()
        let entries = (0..<7).compactMap { offset -> DecraveWidgetEntry? in
            guard let day = calendar.date(byAdding: .day, value: offset, to: startOfToday) else { return nil }
            return entry(for: day, sharedState: sharedState)
        }
        // Keep the next week of date-based quests ready so the widget changes
        // at midnight without waiting for another timeline request.
        completion(Timeline(entries: entries, policy: .atEnd))
    }

    private func entry(for date: Date, sharedState: WidgetSharedState?) -> DecraveWidgetEntry {
        if let sharedState,
           sharedState.dayKey == WidgetSharedStore.dayKey(for: date) {
            return DecraveWidgetEntry(
                date: date,
                questKindRaw: sharedState.questKindRaw,
                questTitle: sharedState.questTitle,
                questBody: sharedState.questBody,
                isCompleted: sharedState.isCompleted,
                radarWeekday: sharedState.radarWeekday,
                radarHour: sharedState.radarHour,
                radarTriggerRaw: sharedState.radarTriggerRaw,
                radarTriggerLabel: sharedState.radarTriggerLabel,
                radarOccurrences: sharedState.radarOccurrences
            )
        }

        return fallbackEntry(for: date)
    }

    private func fallbackEntry(for date: Date) -> DecraveWidgetEntry {
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: date) ?? 1
        switch max(0, dayOfYear - 1) % 3 {
        case 0:
            return DecraveWidgetEntry(
                date: date,
                questKindRaw: "practice_tool",
                questTitle: "Practice your usual SOS",
                questBody: "Run one short intervention before you need it for real.",
                isCompleted: false,
                radarWeekday: nil,
                radarHour: nil,
                radarTriggerRaw: nil,
                radarTriggerLabel: nil,
                radarOccurrences: nil
            )
        case 1:
            return DecraveWidgetEntry(
                date: date,
                questKindRaw: "capture_craving",
                questTitle: "Capture one real moment",
                questBody: "Use SOS once today and record what happened.",
                isCompleted: false,
                radarWeekday: nil,
                radarHour: nil,
                radarTriggerRaw: nil,
                radarTriggerLabel: nil,
                radarOccurrences: nil
            )
        default:
            return DecraveWidgetEntry(
                date: date,
                questKindRaw: "name_trigger",
                questTitle: "Prepare for a familiar trigger",
                questBody: "Name the moment, then choose your response.",
                isCompleted: false,
                radarWeekday: nil,
                radarHour: nil,
                radarTriggerRaw: nil,
                radarTriggerLabel: nil,
                radarOccurrences: nil
            )
        }
    }
}

struct DecraveWidgetEntryView: View {
    @Environment(\.widgetFamily) private var family
    let entry: DecraveWidgetEntry

    var body: some View {
        Link(destination: sosURL) {
            if family == .systemSmall {
                smallLayout
            } else if family == .systemMedium {
                mediumLayout
            } else if family == .systemLarge {
                largeLayout
            } else if family == .accessoryCircular {
                lockScreenCircularLayout
            } else if family == .accessoryInline {
                lockScreenInlineLayout
            } else {
                lockScreenRectangularLayout
            }
        }
        .containerBackground(for: .widget) {
            widgetBackground
        }
    }

    private var smallLayout: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.widgetCoral.opacity(0.18))
                        .frame(width: 34, height: 34)
                    Image(systemName: "bolt.fill")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Color.widgetGold)
                }
                Spacer(minLength: 0)
                Text("SOS")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.white.opacity(0.55))
            }

            Spacer(minLength: 0)

            Text("SOS")
                .font(.system(size: 18, weight: .bold))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            Text(WidgetCopy.tapToOpen)
                .font(.caption2)
                .foregroundStyle(.white.opacity(0.58))
                .lineLimit(1)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(16)
    }

    private var mediumLayout: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 3) {
                Text(WidgetCopy.today)
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(Color.widgetCoral)
                Text(WidgetCopy.questTitle(kind: entry.questKindRaw))
                    .font(.subheadline.weight(.bold))
                    .lineLimit(2)
                    .minimumScaleFactor(0.85)
                    .fixedSize(horizontal: false, vertical: true)
                Text(WidgetCopy.questBody(kind: entry.questKindRaw))
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.58))
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                if let radarText {
                    Text(radarText)
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(Color.widgetViolet)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                statusLabel
            }

            Spacer(minLength: 0)

            VStack(spacing: 7) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.widgetCoral, Color.widgetGold],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 44, height: 44)
                    Image(systemName: "bolt.fill")
                        .font(.headline.weight(.bold))
                        .foregroundStyle(Color.widgetBackground)
                }
                Text("SOS")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.white.opacity(0.78))
            }
            .frame(width: 78)
            .padding(.vertical, 10)
            .background(Color.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.10), lineWidth: 1)
            )
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(16)
    }

    private var largeLayout: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 10) {
                Image(systemName: "wind")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(Color.widgetGold)
                    .frame(width: 28, height: 28)
                    .background(Color.widgetCoral.opacity(0.18), in: Circle())

                Text("DECRAVE")
                    .font(.caption.weight(.bold))
                    .tracking(1.4)
                    .foregroundStyle(.white.opacity(0.72))

                Spacer(minLength: 0)

                Text(WidgetCopy.today)
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(Color.widgetCoral)
            }

            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: questSymbol)
                        .font(.headline.weight(.bold))
                        .foregroundStyle(Color.widgetGold)
                        .frame(width: 40, height: 40)
                        .background(Color.widgetGold.opacity(0.14), in: RoundedRectangle(cornerRadius: 12, style: .continuous))

                    Text(WidgetCopy.questTitle(kind: entry.questKindRaw))
                        .font(.title3.weight(.bold))
                        .lineLimit(2)
                        .minimumScaleFactor(0.85)
                }

                Text(WidgetCopy.questBody(kind: entry.questKindRaw))
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.62))
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)

                if let radarText {
                    Text(radarText)
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(Color.widgetViolet)
                        .lineLimit(1)
                }

                statusLabel
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(16)
            .background(Color.white.opacity(0.075), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.10), lineWidth: 1)
            )

            HStack(spacing: 10) {
                Image(systemName: "bolt.fill")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(Color.widgetBackground)
                    .frame(width: 28, height: 28)
                    .background(
                        LinearGradient(
                            colors: [Color.widgetCoral, Color.widgetGold],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        in: Circle()
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text("SOS")
                        .font(.caption.weight(.bold))
                    Text(WidgetCopy.whenCravingHits)
                        .font(.caption2)
                        .foregroundStyle(.white.opacity(0.58))
                }

                Spacer(minLength: 0)

                Image(systemName: "arrow.up.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white.opacity(0.55))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(18)
    }

    private var questSymbol: String {
        if entry.questKindRaw == "practice_tool" { return "figure.mind.and.body" }
        if entry.questKindRaw == "capture_craving" { return "square.and.pencil" }
        return "scope"
    }

    private var statusLabel: some View {
        Text(entry.isCompleted ? WidgetCopy.completed : WidgetCopy.oneStep)
            .font(.caption2.weight(.bold))
            .foregroundStyle(entry.isCompleted ? Color.widgetGold : .white.opacity(0.48))
            .padding(.top, 2)
    }

    private var radarText: String? {
        guard let weekday = entry.radarWeekday,
              let hour = entry.radarHour,
              (1...7).contains(weekday) else { return nil }

        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: WidgetCopy.languageCode)
        let weekdayName = calendar.shortWeekdaySymbols[weekday - 1]
        let date = calendar.date(from: DateComponents(hour: hour)) ?? Date()
        let formatter = DateFormatter()
        formatter.locale = calendar.locale
        formatter.setLocalizedDateFormatFromTemplate("jm")
        let trigger = entry.radarTriggerRaw.flatMap(WidgetCopy.triggerLabel)
        return WidgetCopy.radar(weekday: weekdayName, hour: formatter.string(from: date), trigger: trigger)
    }

    private var lockScreenCircularLayout: some View {
        ZStack {
            AccessoryWidgetBackground()
            Image(systemName: "bolt.fill")
                .font(.title3.weight(.bold))
                .widgetAccentable()
        }
        .widgetLabel {
            Text("SOS")
        }
    }

    private var lockScreenRectangularLayout: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("DECRAVE")
                .font(.caption2.weight(.bold))
                .widgetAccentable()
            Text("SOS")
                .font(.headline.weight(.bold))
                .lineLimit(1)
            Text(WidgetCopy.tapToOpen)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .widgetLabel {
            Text("SOS")
        }
    }

    private var lockScreenInlineLayout: some View {
        Label("SOS", systemImage: "bolt.fill")
            .widgetAccentable()
    }

    private var widgetBackground: some View {
        ZStack {
            LinearGradient(
                colors: [Color.widgetBackground, Color(red: 0.055, green: 0.066, blue: 0.11), Color.widgetBackground],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Circle()
                .fill(Color.widgetCoral.opacity(0.22))
                .frame(width: 150, height: 150)
                .blur(radius: 34)
                .offset(x: 80, y: -78)

            Circle()
                .fill(Color.widgetViolet.opacity(0.13))
                .frame(width: 130, height: 130)
                .blur(radius: 32)
                .offset(x: -82, y: 86)
        }
    }
}

struct DecraveWidget: Widget {
    let kind = "DecraveWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DecraveWidgetProvider()) { entry in
            DecraveWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Decrave SOS")
        .description(WidgetCopy.description)
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .systemLarge,
            .accessoryCircular,
            .accessoryRectangular,
            .accessoryInline
        ])
        .contentMarginsDisabled()
    }
}

@main
struct DecraveWidgetBundle: WidgetBundle {
    var body: some Widget {
        DecraveWidget()
    }
}
