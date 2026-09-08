//
//  ProLockedSection.swift
//  SlipEasy
//
//  Section-level Pro gate — for one card inside an otherwise-free page
//  (Insights). Deliberately lighter than ProGatedView's whole-page lock
//  (small badge + small pill, not a big centered icon/title/CTA): a full
//  page being locked reads as a wall; one card being locked next to free
//  ones should read as a teaser, matching Decrave's inline "🔒 PLUS"
//  treatment rather than repeating the page-level lock's visual weight.
//

import SwiftUI

struct ProLockedSection<Content: View>: View {
    let unlockLabel: String
    @ViewBuilder let content: () -> Content

    @State private var showPaywall = false

    var body: some View {
        Group {
            if ProAccess.isUnlocked {
                content()
            } else {
                lockedBody
            }
        }
        .padding(20)
        .cardStyle()
        .sheet(isPresented: $showPaywall) {
            PaywallView()
        }
    }

    private var lockedBody: some View {
        ZStack {
            content()
                .disabled(true)
                .accessibilityHidden(true)
                .blur(radius: 8)
                .opacity(0.6)

            VStack(spacing: 10) {
                Text("🔒 \(Strings.Home.proBadge)")
                    .font(.system(size: 10, weight: .bold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.white.opacity(0.08))
                    .clipShape(Capsule())

                Button(unlockLabel) {
                    showPaywall = true
                }
                .buttonStyle(.hapticPlain)
                .font(.caption.bold())
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Color.gold.opacity(0.16))
                .foregroundStyle(Color.gold)
                .clipShape(Capsule())
            }
        }
    }
}

#Preview {
    ProLockedSection(unlockLabel: "Unlock deep insights") {
        Text("Some locked content goes here, blurred behind the badge.")
    }
    .padding()
    .background(Color.appBackground)
}
