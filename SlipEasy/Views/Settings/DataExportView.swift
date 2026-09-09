//
//  DataExportView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

struct DataExportView: View {
    @Query(sort: \CravingLog.timestamp) private var allLogs: [CravingLog]

    private enum ExportRange: String, CaseIterable, Identifiable {
        case week, month, allTime
        var id: String { rawValue }
        var label: String {
            switch self {
            case .week: return Strings.Settings.exportRangeWeek
            case .month: return Strings.Settings.exportRangeMonth
            case .allTime: return Strings.Settings.exportRangeAllTime
            }
        }
    }

    // Defaults to All time so the button's behavior matches what it did
    // before this picker existed, unless someone deliberately narrows it.
    @State private var selectedRange: ExportRange = .allTime
    @State private var exportFileURL: URL?

    var body: some View {
        ProGatedView(lockedBody: Strings.Settings.exportLockedBody) {
            exportBody
        }
    }

    private var exportBody: some View {
        VStack(spacing: 24) {
            Text(Strings.Settings.exportTitle)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text(Strings.Settings.exportDescription)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            VStack(alignment: .leading, spacing: 8) {
                Text(Strings.Settings.exportRangeLabel)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Picker(Strings.Settings.exportRangeLabel, selection: $selectedRange) {
                    ForEach(ExportRange.allCases) { range in
                        Text(range.label).tag(range)
                    }
                }
                .pickerStyle(.segmented)
                // A file already prepared for the old range would silently
                // export stale data through the ShareLink below otherwise.
                .onChange(of: selectedRange) { _, _ in
                    exportFileURL = nil
                }
            }

            Button(action: prepareExport) {
                Text(Strings.Settings.exportButton)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.hapticProminent)
            .controlSize(.large)

            if let exportFileURL {
                ShareLink(item: exportFileURL)
                    .buttonStyle(.hapticPlain)
            }
        }
        .padding(24)
    }

    private var filteredLogs: [CravingLog] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        switch selectedRange {
        case .week:
            guard let start = calendar.date(byAdding: .day, value: -6, to: today) else { return allLogs }
            return allLogs.filter { $0.timestamp >= start }
        case .month:
            guard let start = calendar.date(byAdding: .day, value: -29, to: today) else { return allLogs }
            return allLogs.filter { $0.timestamp >= start }
        case .allTime:
            return allLogs
        }
    }

    private func prepareExport() {
        var csv = "Date,Time,Outcome,Trigger,Intensity\n"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"

        for log in filteredLogs.sorted(by: { $0.timestamp < $1.timestamp }) {
            let date = dateFormatter.string(from: log.timestamp)
            let time = timeFormatter.string(from: log.timestamp)
            let outcome = log.outcome.rawValue
            let trigger = log.trigger?.rawValue ?? ""
            csv += "\(date),\(time),\(outcome),\(trigger),\(log.intensity)\n"
        }

        let url = FileManager.default.temporaryDirectory.appendingPathComponent("Decrave-export.csv")
        try? csv.write(to: url, atomically: true, encoding: .utf8)
        exportFileURL = url
    }
}

#Preview {
    NavigationStack {
        DataExportView()
    }
    .modelContainer(for: CravingLog.self, inMemory: true)
}
