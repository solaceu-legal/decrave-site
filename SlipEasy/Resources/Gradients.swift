//
//  Gradients.swift
//  SlipEasy
//
//  A small set of brand gradients layered on top of the system semantic
//  color palette — not a replacement for it. Reserved for hero moments
//  (big numbers, progress rings, the SOS button) that earn a stronger
//  accent than Color.accentColor; everything else keeps using system
//  colors so light/dark mode keeps working automatically.
//

import SwiftUI

extension LinearGradient {
    /// Mint → sky → violet. Calm, forward-looking — used for the numbers
    /// and rings the app wants to feel proud of (money saved, momentum).
    static let brand = LinearGradient(
        colors: [
            Color(red: 0.231, green: 0.910, blue: 0.690),
            Color(red: 0.322, green: 0.773, blue: 1.0),
            Color(red: 0.612, green: 0.549, blue: 1.0)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    /// Coral → gold. Reserved for the single SOS entry point — the one
    /// moment the app should feel urgent and warm rather than calm.
    static let warm = LinearGradient(
        colors: [
            Color(red: 1.0, green: 0.478, blue: 0.349),
            Color(red: 1.0, green: 0.698, blue: 0.361)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
