//
//  MainFlowView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

private enum MainTab: String {
    case home, progress
}

private enum MainPresentation: String, Identifiable {
    case sos, logConfirmation
    var id: String { rawValue }
}

struct MainFlowView: View {
    @Binding var requestedSOSSource: SOSLaunchSource?
    @SceneStorage("mainTab") private var selectedTabRaw = MainTab.home.rawValue
    @AppStorage(AppLanguage.storageKey) private var appLanguageCode = AppLanguage.english.rawValue
    @State private var homePath: [AppRoute] = []
    @State private var presentation: MainPresentation?
    @State private var returnAfterConfirmation: (() -> Void)?
    @State private var sosInitialTrigger: CravingTrigger?
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let fabSize = CGSize(width: 128, height: 52)

    private var selectedTab: MainTab {
        MainTab(rawValue: selectedTabRaw) ?? .home
    }

    init(requestedSOSSource: Binding<SOSLaunchSource?> = .constant(nil)) {
        _requestedSOSSource = requestedSOSSource
    }

    var body: some View {
        // Keep SOS in the center slot as the primary action. Progress is
        // the single place for Insights and account/settings content.
        Group {
            switch selectedTab {
            case .home:
                NavigationStack(path: $homePath) {
                    HomeView(
                        path: $homePath,
                        onOpenInsights: { selectedTabRaw = MainTab.progress.rawValue },
                        onStartQuest: { trigger in
                            presentSOS(source: .dailyQuest, trigger: trigger)
                        }
                    )
                    .id(appLanguageCode)
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route, path: $homePath)
                    }
                }
            case .progress:
                ProgressHubView(onStartSOS: { trigger in
                    presentSOS(source: .button, trigger: trigger)
                }, onLogSaved: { onReturn in
                    returnAfterConfirmation = onReturn
                    presentation = .logConfirmation
                })
            }
        }
        .safeAreaInset(edge: .bottom) {
            tabBar
        }
        .background(Color.appBackground)
        .fullScreenCover(item: $presentation) { presented in
            switch presented {
            case .sos:
                SOSFlowView(initialTrigger: sosInitialTrigger)
            case .logConfirmation:
                RelapseConfirmationView(path: .constant([]), onReturn: {
                    returnAfterConfirmation?()
                    returnAfterConfirmation = nil
                    presentation = nil
                })
            }
        }
        .onAppear {
            presentRequestedSOSIfNeeded()
        }
        .onChange(of: requestedSOSSource) { _, _ in
            presentRequestedSOSIfNeeded()
        }
    }

    @ViewBuilder
    private func destination(for route: AppRoute, path: Binding<[AppRoute]>) -> some View {
        switch route {
        case .log(let outcome, let tool):
            LogView(outcome: outcome, tool: tool, path: path, contextTrigger: .constant(nil))
        case .relapseConfirmation:
            RelapseConfirmationView(path: path)
        case .dataExport:
            DataExportView()
        case .settings:
            EmptyView() // settings belongs to the Progress navigation stack
        case .intervention, .toolbox:
            EmptyView() // unreachable here — those routes belong to SOSFlowView's own stack
        }
    }

    // MARK: - Tab bar

    private var tabBar: some View {
        HStack(spacing: 0) {
            tabButton(.home, icon: "house.fill", label: Strings.Tab.home)
                .frame(maxWidth: .infinity)

            sosButton
                .frame(maxWidth: .infinity)

            tabButton(.progress, icon: "chart.bar.xaxis", label: Strings.Tab.progress)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            LinearGradient(
                colors: [Color.black.opacity(0.78), Color.black.opacity(0.94)],
                startPoint: .top,
                endPoint: .bottom
            )
            .background(.ultraThinMaterial)
            .overlay(alignment: .top) {
                Rectangle().fill(Color.cardStroke).frame(height: 1)
            }
            .ignoresSafeArea(edges: .bottom)
        )
    }

    private func tabButton(_ tab: MainTab, icon: String, label: String) -> some View {
        Button {
            selectedTabRaw = tab.rawValue
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 21))
                Text(label)
                    .font(.system(size: 10, weight: .semibold))
            }
            .foregroundStyle(selectedTab == tab ? Color.accentColor : Color.white.opacity(0.35))
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(selectedTab == tab ? .isSelected : [])
    }

    private var sosButton: some View {
        Button {
            presentSOS(source: .button)
        } label: {
            ZStack {
                pulseRing
                Capsule()
                    .fill(LinearGradient.warm)
                    .shadow(color: .orange.opacity(0.45), radius: 10, y: 4)
                Text(Strings.Tab.sosButtonShortLabel)
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundStyle(Color.black.opacity(0.75))
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                    .padding(.horizontal, 10)
            }
            .frame(width: fabSize.width, height: fabSize.height)
        }
        .buttonStyle(.hapticPlain)
        .accessibilityLabel(Strings.Tab.sosButtonLabel)
    }

    private func presentRequestedSOSIfNeeded() {
        guard let source = requestedSOSSource else { return }
        requestedSOSSource = nil
        presentSOS(source: source)
    }

    private func presentSOS(source: SOSLaunchSource, trigger: CravingTrigger? = nil) {
        sosInitialTrigger = trigger
        presentation = .sos
        Analytics.trackSOSOpened(source: source.rawValue)
    }

    private var pulseRing: some View {
        TimelineView(.animation(paused: reduceMotion)) { context in
            let cycle = 2.4
            let t = (context.date.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: cycle)) / cycle
            Capsule()
                .stroke(Color.orange.opacity(reduceMotion ? 0.3 : (1 - t) * 0.5), lineWidth: 2)
                .scaleEffect(reduceMotion ? 1 : 1 + t * 0.16)
        }
        .frame(width: fabSize.width, height: fabSize.height)
    }
}

#Preview {
    MainFlowView()
        .modelContainer(for: CravingLog.self, inMemory: true)
}
