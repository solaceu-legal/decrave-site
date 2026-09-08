//
//  SettingsView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Binding var path: [AppRoute]

    @Query(filter: #Predicate<CravingLog> { $0.outcomeRaw == "beaten" })
    private var beatenLogs: [CravingLog]

    @Query(filter: #Predicate<CravingLog> { $0.outcomeRaw == "smoked" })
    private var smokedLogs: [CravingLog]

    @AppStorage("pricePerPack") private var pricePerPack: Double = 8.5
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false

    @State private var restoreResult: RestoreResult?
    @State private var showPaywall = false
    @State private var showPromise = false

    private enum RestoreResult: Identifiable, Hashable {
        case success, empty, failure

        var id: Self { self }

        var title: String {
            switch self {
            case .success: Strings.Settings.restoreSuccessTitle
            case .empty: Strings.Settings.restoreEmptyTitle
            case .failure: Strings.Settings.restoreErrorTitle
            }
        }

        var message: String {
            switch self {
            case .success: Strings.Settings.restoreSuccessMessage
            case .empty: Strings.Settings.restoreEmptyMessage
            case .failure: Strings.Settings.restoreErrorMessage
            }
        }
    }

    private var beatenCount: Int { beatenLogs.count }

    private var momentum: Int {
        InsightsEngine.momentumScore(beatenCount: beatenCount, smokedCount: smokedLogs.count)
    }

    private var formattedMoneySaved: String {
        InsightsEngine.moneySaved(beatenCount: beatenCount, pricePerPack: pricePerPack)
            .formatted(.currency(code: "USD"))
    }

    var body: some View {
        List {
            Section {
                membershipCard
            }
            .listRowBackground(Color.clear)

            Section(Strings.Settings.yourNumbersHeader) {
                statsGrid
            }
            .listRowBackground(Color.cardFill)

            Section {
                Button {
                    showPromise = true
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "shield.fill")
                            .foregroundStyle(Color.accentColor)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(Strings.Settings.promiseTitle)
                                .foregroundStyle(.primary)
                            Text(Strings.Settings.promiseSubtitle)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .listRowBackground(Color.cardFill)

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
            .listRowBackground(Color.cardFill)

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
                    restorePurchases()
                } label: {
                    Text(Strings.Settings.restorePurchases)
                }
            }
            .listRowBackground(Color.cardFill)

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
            .listRowBackground(Color.cardFill)

            Section {
                Button {
                    path.append(.log(outcome: .smoked, tool: nil))
                } label: {
                    Text(Strings.Settings.logSlipRow)
                        .foregroundStyle(.secondary)
                }
            }
            .listRowBackground(Color.cardFill)

            // Guaranteed clearance above the custom tab bar's floating
            // SOS button — see Layout.tabBarClearance.
            Section {
                Color.clear.frame(height: Layout.tabBarClearance)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .scrollContentBackground(.hidden)
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle(Strings.Settings.title)
        .task {
            let isAuthorized = await NotificationManager.isAuthorized()
            if !isAuthorized && notificationsEnabled {
                notificationsEnabled = false
            }
        }
        .alert(item: $restoreResult) { result in
            Alert(title: Text(result.title), message: Text(result.message), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $showPaywall) {
            PaywallView()
        }
        .sheet(isPresented: $showPromise) {
            NeverResetPromiseView()
        }
    }

    private var membershipCard: some View {
        HStack(spacing: 14) {
            Text("✨")
                .font(.title2)
                .frame(width: 44, height: 44)
                .background(Color.gold.opacity(0.16))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

            VStack(alignment: .leading, spacing: 2) {
                Text(ProAccess.isUnlocked ? Strings.Settings.memberTitle : Strings.Settings.freeTitle)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                Text(ProAccess.isUnlocked ? Strings.Settings.memberSubtitle : Strings.Settings.freeSubtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if !ProAccess.isUnlocked {
                Button(Strings.Settings.tryProCTA) {
                    showPaywall = true
                }
                .buttonStyle(.hapticPlain)
                .font(.caption.bold())
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.accentColor)
                .foregroundStyle(.white)
                .clipShape(Capsule())
            }
        }
        .padding(16)
        .background(
            LinearGradient(
                colors: [Color.gold.opacity(0.16), Color.coral.opacity(0.10)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(Color.gold.opacity(0.3), lineWidth: 1)
        )
        .padding(.vertical, 6)
    }

    private var statsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            statTile(value: formattedMoneySaved, label: Strings.Settings.moneySavedLabel, color: .mint)
            statTile(value: "\(beatenCount)", label: Strings.Settings.cigsAvoidedLabel, color: .cyan)
            statTile(value: "\(beatenCount)", label: Strings.Settings.cravingsBeatenLabel, color: .purple)
            statTile(value: "\(momentum)", label: Strings.Settings.momentumLabel, color: Color.gold)
        }
        .padding(.vertical, 8)
    }

    private func statTile(value: String, label: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(value)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(color)
                .minimumScaleFactor(0.6)
                .lineLimit(1)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func restorePurchases() {
        Task {
            do {
                try await StoreManager.shared.restorePurchases()
                restoreResult = StoreManager.shared.isPro ? .success : .empty
            } catch {
                restoreResult = .failure
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(path: .constant([]))
    }
    .modelContainer(for: CravingLog.self, inMemory: true)
}
