//
//  MainFlowView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

private enum MainTab {
    case home, insights, you
}

struct MainFlowView: View {
    @State private var selectedTab: MainTab = .home
    @State private var homePath: [AppRoute] = []
    @State private var youPath: [AppRoute] = []
    @State private var isSOSPresented = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let fabSize = CGSize(width: 128, height: 52)
    // Taller than fabSize.height on purpose — the SOS button is centered
    // inside this band as a plain SwiftUI .overlay (see tabBar), so it's
    // guaranteed to sit fully within whatever height safeAreaInset ends
    // up reserving, with no offset math against the home indicator's
    // height (which differs between the simulator and real devices and
    // was the actual cause of the clipping this replaces).
    private let fabBandHeight: CGFloat = 60

    var body: some View {
        // Column order in the flat row (Home, Insights, You) mirrors
        // Decrave's own tab bar with Pod (social, out of scope) dropped;
        // the SOS button floats above that row as its own band rather
        // than a 4th column, so it can sit at the true horizontal center.
        Group {
            switch selectedTab {
            case .home:
                NavigationStack(path: $homePath) {
                    HomeView(
                        path: $homePath,
                        onOpenInsights: { selectedTab = .insights },
                        onStartQuest: { isSOSPresented = true }
                    )
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route, path: $homePath)
                    }
                }
            case .insights:
                NavigationStack {
                    WeeklyReportView()
                }
            case .you:
                NavigationStack(path: $youPath) {
                    SettingsView(path: $youPath)
                        .navigationDestination(for: AppRoute.self) { route in
                            destination(for: route, path: $youPath)
                        }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            tabBar
        }
        .background(Color.appBackground)
        .fullScreenCover(isPresented: $isSOSPresented) {
            SOSFlowView()
        }
    }

    @ViewBuilder
    private func destination(for route: AppRoute, path: Binding<[AppRoute]>) -> some View {
        switch route {
        case .log(let outcome, let tool):
            LogView(outcome: outcome, tool: tool, path: path)
        case .relapseConfirmation:
            RelapseConfirmationView(path: path)
        case .dataExport:
            DataExportView()
        case .intervention, .toolbox:
            EmptyView() // unreachable here — those routes belong to SOSFlowView's own stack
        }
    }

    // MARK: - Tab bar

    private var tabBar: some View {
        VStack(spacing: 0) {
            // sosButton is a direct VStack child (not an .overlay on a
            // Color.clear spacer) on purpose — an overlay's size doesn't
            // reliably count toward what .safeAreaInset measures and
            // reserves for the whole bar, which is what let this button
            // clip the bottom of scrollable content before. As a real
            // child with explicit padding, its height is unambiguous.
            sosButton
                .padding(.vertical, (fabBandHeight - fabSize.height) / 2)

            HStack(spacing: 0) {
                tabButton(.home, icon: "house.fill", label: Strings.Tab.home)
                    .frame(maxWidth: .infinity)
                tabButton(.insights, icon: "chart.bar.fill", label: Strings.Tab.insights)
                    .frame(maxWidth: .infinity)
                tabButton(.you, icon: "person.crop.circle.fill", label: Strings.Tab.you)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 8)
        }
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
            selectedTab = tab
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
            isSOSPresented = true
        } label: {
            ZStack {
                pulseRing
                Capsule()
                    .fill(LinearGradient.warm)
                    .shadow(color: .orange.opacity(0.45), radius: 10, y: 4)
                Text(Strings.Tab.sosButtonShortLabel)
                    .font(.system(size: 14, weight: .heavy))
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
