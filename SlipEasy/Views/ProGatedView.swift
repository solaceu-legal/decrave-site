//
//  ProGatedView.swift
//  SlipEasy
//

import SwiftUI

/// Wraps any Pro feature's real content: shown as-is when unlocked, shown
/// as a blurred (not empty) preview behind a lock card when not — reused
/// by the weekly report and data export, so the paywall look only lives
/// in one place.
struct ProGatedView<Content: View>: View {
    let lockedBody: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        if ProAccess.isUnlocked {
            ScrollView {
                content()
            }
        } else {
            // GeometryReader + minHeight: the lock card stays centered at
            // normal text sizes but scrolls instead of spilling off-screen
            // at max Dynamic Type (same pattern as InterventionEndView).
            GeometryReader { geometry in
                ScrollView {
                    ZStack {
                        content()
                            .disabled(true)
                            .accessibilityHidden(true)
                            .blur(radius: 14)

                        lockedCard
                    }
                    .frame(minHeight: geometry.size.height)
                }
            }
        }
    }

    private var lockedCard: some View {
        VStack(spacing: 16) {
            Image(systemName: "lock.fill")
                .font(.largeTitle)
                .foregroundStyle(.secondary)

            Text(Strings.Report.lockedTitle)
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)

            Text(lockedBody)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)

            Button(Strings.Report.unlockCTA) {
                // Phase 6 wires this to the real StoreKit paywall.
            }
            .buttonStyle(.hapticProminent)
            .controlSize(.large)
        }
        .padding(24)
        .frame(maxWidth: 340)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(24)
    }
}

#Preview {
    ProGatedView(lockedBody: Strings.Report.lockedBody) {
        Text("Real content")
    }
}
