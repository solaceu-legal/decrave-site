//
//  SOSToolboxView.swift
//  SlipEasy
//
//  Reached from either intervention when the craving hasn't eased yet —
//  a grid of quick, active things to try instead of just waiting. Every
//  tool here is a self-contained toast or timer; none of them write to
//  CravingLog on their own, only the two buttons at the bottom do.
//

import SwiftUI

struct SOSToolboxView: View {
    @Binding var path: [AppRoute]

    @State private var toastMessage: String?
    @State private var delayEndDate: Date?

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    header

                    LazyVGrid(columns: columns, spacing: 12) {
                        delayCard
                        toolCard(icon: "snowflake", title: Strings.SOS.iceTitle, subtitle: Strings.SOS.iceSubtitle, toast: Strings.SOS.iceToast)
                        toolCard(icon: "figure.run", title: Strings.SOS.moveTitle, subtitle: Strings.SOS.moveSubtitle, toast: Strings.SOS.moveToast)
                        toolCard(icon: "pills.fill", title: Strings.SOS.nrtTitle, subtitle: Strings.SOS.nrtSubtitle, toast: Strings.SOS.nrtToast)
                        toolCard(icon: "text.quote", title: Strings.SOS.whyTitle, subtitle: Strings.SOS.whySubtitle, toast: Strings.SOS.whyToast)
                    }
                    .padding(.horizontal, 24)

                    Spacer(minLength: 0)

                    footerButtons
                }
                .padding(.top, 24)
                .frame(minHeight: geometry.size.height)
            }
        }
        .background(Color.appBackground.ignoresSafeArea())
        .overlay(alignment: .top) { toastView }
        .navigationBarBackButtonHidden(true)
    }

    private var header: some View {
        VStack(spacing: 8) {
            Text(Strings.SOS.toolboxTitle)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text(Strings.SOS.toolboxSubtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 24)
    }

    private var delayCard: some View {
        Button {
            if delayEndDate == nil {
                delayEndDate = Date().addingTimeInterval(240)
            }
        } label: {
            VStack(alignment: .leading, spacing: 6) {
                Image(systemName: "hourglass")
                    .font(.title3)
                    .foregroundStyle(Color.coral)
                Text(Strings.SOS.delayTitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                if let delayEndDate {
                    TimelineView(.periodic(from: .now, by: 1)) { context in
                        let remaining = max(0, Int(delayEndDate.timeIntervalSince(context.date)))
                        Text(remaining > 0 ? "\(remaining / 60):\(String(format: "%02d", remaining % 60)) left" : Strings.SOS.delayDone)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                } else {
                    Text(Strings.SOS.delaySubtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .cardStyle()
        }
        .buttonStyle(.plain)
    }

    private func toolCard(icon: String, title: String, subtitle: String, toast: String) -> some View {
        Button {
            toastMessage = toast
        } label: {
            VStack(alignment: .leading, spacing: 6) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(Color.coral)
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .cardStyle()
        }
        .buttonStyle(.plain)
    }

    private var footerButtons: some View {
        VStack(spacing: 12) {
            Button {
                path.append(.log(outcome: .beaten, tool: nil))
            } label: {
                Text(Strings.SOS.feelBetter)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.hapticProminent)
            .controlSize(.large)

            Button {
                path.append(.log(outcome: .smoked, tool: nil))
            } label: {
                Text(Strings.SOS.stillSmoked)
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(.hapticPlain)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }

    @ViewBuilder
    private var toastView: some View {
        if let toastMessage {
            Text(toastMessage)
                .font(.subheadline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.thinMaterial, in: Capsule())
                .padding(.horizontal, 32)
                .padding(.top, 70)
                .transition(.move(edge: .top).combined(with: .opacity))
                .task(id: toastMessage) {
                    try? await Task.sleep(for: .seconds(2.5))
                    self.toastMessage = nil
                }
        }
    }
}

#Preview {
    NavigationStack {
        SOSToolboxView(path: .constant([]))
    }
}
