//
//  DataExportView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

struct DataExportView: View {
    @Query(sort: \CravingLog.timestamp) private var allLogs: [CravingLog]

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

    private func prepareExport() {
        var csv = "Date,Time,Outcome,Trigger,Intensity\n"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"

        for log in allLogs.sorted(by: { $0.timestamp < $1.timestamp }) {
            let date = dateFormatter.string(from: log.timestamp)
            let time = timeFormatter.string(from: log.timestamp)
            let outcome = log.outcome.rawValue
            let trigger = log.trigger?.rawValue ?? ""
            csv += "\(date),\(time),\(outcome),\(trigger),\(log.intensity)\n"
        }

        let url = FileManager.default.temporaryDirectory.appendingPathComponent("SlipEasy-export.csv")
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
