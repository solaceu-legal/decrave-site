//
//  SettingsView.swift
//  SlipEasy
//

import SwiftUI

struct SettingsView: View {
    @Binding var path: [AppRoute]

    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    @State private var showRestoreAlert = false

    var body: some View {
        List {
            Section {
                Toggle(Strings.Settings.notificationsToggle, isOn: $notificationsEnabled)
                    .onChange(of: notificationsEnabled) { _, newValue in
                        if newValue {
                            Task {
                                let granted = await NotificationManager.requestAuthorizationAndSchedule()
                                if !granted {
                                    notificationsEnabled = false
                                }
                            }
                        } else {
                            NotificationManager.cancel()
                        }
                    }
            } footer: {
                Text(Strings.Settings.notificationsFooter)
            }

            Section(Strings.Settings.proSectionHeader) {
                Button {
                    path.append(.dataExport)
                } label: {
                    HStack {
                        Text(Strings.Settings.dataExportRow)
                            .foregroundStyle(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                if let url = URL(string: "https://apps.apple.com/account/subscriptions") {
                    Link(destination: url) {
                        Text(Strings.Settings.manageSubscription)
                    }
                }

                Button {
                    showRestoreAlert = true
                } label: {
                    Text(Strings.Settings.restorePurchases)
                }
            }

            Section(Strings.Settings.legalSectionHeader) {
                if let url = URL(string: Strings.Settings.privacyPolicyURL) {
                    Link(destination: url) {
                        Text(Strings.Settings.privacyPolicy)
                    }
                }
                if let url = URL(string: Strings.Settings.termsOfUseURL) {
                    Link(destination: url) {
                        Text(Strings.Settings.termsOfUse)
                    }
                }
            }
        }
        .navigationTitle(Strings.Settings.title)
        .task {
            let isAuthorized = await NotificationManager.isAuthorized()
            if !isAuthorized && notificationsEnabled {
                notificationsEnabled = false
            }
        }
        .alert(Strings.Settings.restoreAlertTitle, isPresented: $showRestoreAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(Strings.Settings.restoreAlertMessage)
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(path: .constant([]))
    }
}
