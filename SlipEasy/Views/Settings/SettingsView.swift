//
//  SettingsView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Binding var path: [AppRoute]
    @Environment(\.dismiss) private var dismiss

    @Query(filter: #Predicate<CravingLog> { $0.outcomeRaw == "beaten" })
    private var beatenLogs: [CravingLog]

    @Query(filter: #Predicate<CravingLog> { $0.outcomeRaw == "smoked" })
    private var smokedLogs: [CravingLog]

    @AppStorage("pricePerPack") private var pricePerPack: Double = 8.5
    @AppStorage(MoneySettings.currencyStorageKey) private var priceCurrencyCode = MoneySettings.deviceCurrencyCode
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    @AppStorage(Analytics.consentKey) private var analyticsEnabled = false
    @AppStorage(AppLanguage.storageKey) private var appLanguageCode = AppLanguage.english.rawValue

    @State private var restoreResult: RestoreResult?
    @State private var showPaywall = false
    @State private var showPromise = false
    @State private var showPackPriceEditor = false

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
        let logs = (beatenLogs + smokedLogs).map {
            LogSummary(timestamp: $0.timestamp, outcome: $0.outcome, trigger: $0.trigger, usedIntervention: $0.interventionTool != nil, interventionTool: $0.interventionTool)
        }
        return InsightsEngine.momentumScore(logs: logs)
    }

    private var formattedMoneySaved: String {
        InsightsEngine.formattedMoney(InsightsEngine.moneySaved(beatenCount: beatenCount, pricePerPack: pricePerPack), currencyCode: priceCurrencyCode)
    }

    private var allLogSummaries: [LogSummary] {
        (beatenLogs + smokedLogs).map {
            LogSummary(timestamp: $0.timestamp, outcome: $0.outcome, trigger: $0.trigger, usedIntervention: $0.interventionTool != nil, interventionTool: $0.interventionTool)
        }
    }

    private var predictedWindow: InsightsEngine.PredictedWindow? {
        InsightsEngine.predictedCravingWindow(logs: allLogSummaries)
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Text(Strings.Settings.pageTitle)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer(minLength: 16)
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.body.weight(.semibold))
                        .frame(width: 44, height: 44)
                        .background(Color.cardFill, in: Circle())
                        .overlay(Circle().strokeBorder(Color.cardStroke, lineWidth: 1))
                        .contentShape(Circle())
                }
                .buttonStyle(.plain)
                .foregroundStyle(.primary)
                .accessibilityLabel(Strings.Settings.close)
            }
            .padding(.horizontal, 24)
            .padding(.top, 12)

            // The settings screen is pushed inside the Progress tab, so the
            // main tab bar remains visible. Extra scroll room keeps the final
            // action clear of that bar after the scroll settles.
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    languageCard

                    packPriceCard

                    membershipCard

                    sectionCard(eyebrow: Strings.Settings.yourNumbersHeader) {
                        statsGrid
                    }

                    promiseRow

                    notificationCard

                    analyticsCard

                    sectionCard(eyebrow: Strings.Settings.proSectionHeader) {
                        proActions
                    }

                    sectionCard(eyebrow: Strings.Settings.legalSectionHeader) {
                        legalLinks
                    }

                    logSlipButton
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 120)
            }
        }
        .background(Color.appBackground.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .task {
            let isAuthorized = await NotificationManager.isAuthorized()
            if !isAuthorized && notificationsEnabled {
                notificationsEnabled = false
            } else if isAuthorized && notificationsEnabled {
                NotificationManager.refreshSchedule(predictedWindow: predictedWindow)
            }
        }
        .alert(item: $restoreResult) { result in
            Alert(title: Text(result.title), message: Text(result.message), dismissButton: .default(Text(Strings.Settings.ok)))
        }
        .sheet(isPresented: $showPaywall) {
            PaywallView()
        }
        .sheet(isPresented: $showPromise) {
            NeverResetPromiseView()
        }
        .sheet(isPresented: $showPackPriceEditor) {
            PackPriceEditorView(pricePerPack: $pricePerPack, currencyCode: $priceCurrencyCode)
        }
    }

    // Same eyebrow-caption-inside-a-card grouping as
    // WeeklyReportView.freeSectionCard — kept as its own copy since the two
    // views don't otherwise share a base, but the visual language should
    // match everywhere a card needs a small label above its content.
    private func sectionCard<Content: View>(eyebrow: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(eyebrow)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .cardStyle()
    }

    private var languageCard: some View {
        HStack(spacing: 12) {
            Image(systemName: "globe")
                .font(.title3)
                .foregroundStyle(Color.accentColor)
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 2) {
                Text(Strings.Settings.languageTitle)
                    .font(.headline)
                Text(Strings.Settings.languageSubtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 8)

            Menu {
                ForEach(AppLanguage.allCases) { language in
                    Button {
                        appLanguageCode = language.rawValue
                        WidgetSharedStore.saveLanguage(language.rawValue)
                    } label: {
                        HStack {
                            Text(language.displayName)
                            if language.rawValue == appLanguageCode {
                                Spacer()
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack(spacing: 5) {
                    Text(selectedLanguage.displayName)
                        .font(.subheadline.weight(.semibold))
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.caption2.weight(.bold))
                }
            }
            .tint(Color.accentColor)
            .accessibilityLabel(Strings.Settings.languageTitle)
        }
        .padding(16)
        .cardStyle()
    }

    private var selectedLanguage: AppLanguage {
        AppLanguage(rawValue: appLanguageCode) ?? .english
    }

    private var packPriceCard: some View {
        Button {
            showPackPriceEditor = true
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "banknote")
                    .font(.title3)
                    .foregroundStyle(Color.accentColor)
                    .frame(width: 28)
                Text(Strings.Money.packPrice)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Spacer(minLength: 8)
                Text(InsightsEngine.formattedMoney(pricePerPack, currencyCode: priceCurrencyCode))
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.accentColor)
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .contentShape(Rectangle())
            .padding(16)
            .cardStyle()
        }
        .buttonStyle(.plain)
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
        .frame(maxWidth: .infinity)
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
    }

    private var promiseRow: some View {
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
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.hapticPlain)
        .padding(20)
        .cardStyle()
    }

    private var notificationCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle(Strings.Settings.notificationsToggle, isOn: $notificationsEnabled)
                .onChange(of: notificationsEnabled) { _, newValue in
                    if newValue {
                        Task {
                            let granted = await NotificationManager.requestAuthorizationAndSchedule(predictedWindow: predictedWindow)
                            if !granted {
                                notificationsEnabled = false
                            }
                        }
                    } else {
                        NotificationManager.cancel()
                    }
                }
            Text(notificationFooter)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .cardStyle()
    }

    private var notificationFooter: String {
        guard let predictedWindow else { return Strings.Settings.notificationsDefaultFooter }
        return Strings.Settings.notificationsPatternFooter(
            weekday: predictedWindow.weekdayName,
            hour: predictedWindow.formattedHour,
            occurrences: predictedWindow.occurrences
        )
    }

    private var analyticsCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle(Strings.Settings.analyticsToggle, isOn: $analyticsEnabled)
                .onChange(of: analyticsEnabled) { _, newValue in
                    Analytics.setConsent(newValue)
                }
            Text(Strings.Settings.analyticsFooter)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .cardStyle()
    }

    private var proActions: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button {
                path.append(.dataExport)
            } label: {
                Text(Strings.Settings.dataExportRow)
                    .foregroundStyle(Color.accentColor)
            }
            .buttonStyle(.hapticPlain)

            Button {
                restorePurchases()
            } label: {
                Text(Strings.Settings.restorePurchases)
                    .foregroundStyle(Color.accentColor)
            }
            .buttonStyle(.hapticPlain)
        }
    }

    private var legalLinks: some View {
        VStack(alignment: .leading, spacing: 12) {
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

    private var logSlipButton: some View {
        Button {
            path.append(.log(outcome: .smoked, tool: nil))
        } label: {
            Text(Strings.Settings.logSlipRow)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .cardStyle()
                .contentShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
        .buttonStyle(.hapticPlain)
    }

    private var statsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            statTile(value: formattedMoneySaved, label: Strings.Settings.moneySavedLabel, color: .mint)
            statTile(value: "\(beatenCount)", label: Strings.Settings.cigsAvoidedLabel, color: .cyan)
            statTile(value: "\(beatenCount)", label: Strings.Settings.cravingsBeatenLabel, color: .purple)
            statTile(value: "\(momentum)", label: Strings.Settings.momentumLabel, color: Color.gold)
        }
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
