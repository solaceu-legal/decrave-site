//
//  Theme.swift
//  SlipEasy
//
//  Decrave-matched colors that the system semantic palette doesn't cover.
//  App-wide dark mode is forced (see SlipEasyApp), so Color.primary/
//  .secondary already resolve to their dark variants everywhere without
//  needing to touch every file — these fill the remaining gap: the
//  specific near-black background and translucent card surfaces.
//

import SwiftUI

enum Layout {
    // Explicit, guaranteed clearance for scrollable tab content above the
    // custom tab bar (see MainFlowView) — `.safeAreaInset` alone under-
    // reserves space here (it only seems to count the flat row, not the
    // floating "Decrave it" button's band above it, once a view also
    // carries its own `.ignoresSafeArea()` background), so every
    // scrollable tab adds this on top rather than relying on that
    // propagation to be exact. Generous on purpose — a little extra
    // whitespace at the bottom beats clipped content.
    static let tabBarClearance: CGFloat = 140
}

extension Color {
    /// #070B11 — Decrave's near-black background.
    static let appBackground = Color(red: 0.027, green: 0.043, blue: 0.067)
    static let cardFill = Color.white.opacity(0.045)
    static let cardFillElevated = Color.white.opacity(0.085)
    static let cardStroke = Color.white.opacity(0.09)
    /// #FF7A59 — the warm gradient's start color, also used standalone
    /// (e.g. glows, badges) where a flat color reads better than a gradient.
    static let coral = Color(red: 1.0, green: 0.478, blue: 0.349)
    /// #FFC96B
    static let gold = Color(red: 1.0, green: 0.788, blue: 0.42)
    /// #52C5FF — the middle stop of LinearGradient.brand, exposed on its
    /// own for Trigger Radar's module-specific accent.
    static let sky = Color(red: 0.322, green: 0.773, blue: 1.0)
    /// #9C8CFF — the final stop of LinearGradient.brand, exposed on its
    /// own for Today's Quest's module-specific accent.
    static let violet = Color(red: 0.612, green: 0.549, blue: 1.0)
}

/// The one card look used everywhere: 24pt rounded corners, a faint
/// translucent fill, and a 1px stroke — replaces the
/// `Color(.secondarySystemBackground) + RoundedRectangle` pairing used
/// throughout the pre-redesign screens.
struct CardBackground: ViewModifier {
    var elevated: Bool = false

    func body(content: Content) -> some View {
        content
            .background(elevated ? Color.cardFillElevated : Color.cardFill)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .strokeBorder(Color.cardStroke, lineWidth: 1)
            )
    }
}

extension View {
    func cardStyle(elevated: Bool = false) -> some View {
        modifier(CardBackground(elevated: elevated))
    }
}
