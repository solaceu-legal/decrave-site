//
//  ProgressView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

/// The single secondary destination in the main flow. Insights stays the
/// primary content; account and settings are one level down so the bottom
/// navigation remains focused on Home, SOS, and personal progress.
struct ProgressHubView: View {
    var onStartSOS: (CravingTrigger?) -> Void = { _ in }
    var onLogSaved: (@escaping () -> Void) -> Void = { $0() }

    @State private var settingsPath: [AppRoute] = []
    @AppStorage(AppLanguage.storageKey) private var appLanguageCode = AppLanguage.english.rawValue

    var body: some View {
        NavigationStack(path: $settingsPath) {
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    Text(Strings.Report.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer(minLength: 16)
                    NavigationLink(value: AppRoute.settings) {
                        Image(systemName: "gearshape")
                            .font(.body.weight(.semibold))
                            .frame(width: 44, height: 44)
                            .background(Color.cardFill, in: Circle())
                            .overlay(Circle().strokeBorder(Color.cardStroke, lineWidth: 1))
                            .contentShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(Strings.Tab.settings)
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)

                WeeklyReportView(onStartSOS: onStartSOS, showsHeader: false)
                    .id(appLanguageCode)
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .settings:
                    SettingsView(path: $settingsPath)
                case .dataExport:
                    DataExportView()
                case .log(let outcome, let tool):
                    LogView(
                        outcome: outcome,
                        tool: tool,
                        path: $settingsPath,
                        contextTrigger: .constant(nil),
                        onSaved: {
                            onLogSaved {
                                if !settingsPath.isEmpty {
                                    settingsPath.removeLast()
                                }
                            }
                        }
                    )
                case .relapseConfirmation, .intervention, .toolbox:
                    EmptyView()
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ProgressHubView()
        .modelContainer(for: CravingLog.self, inMemory: true)
}
