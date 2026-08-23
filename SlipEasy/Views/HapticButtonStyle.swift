//
//  HapticButtonStyle.swift
//  SlipEasy
//
//  Wraps the standard button styles with a light haptic tap on press.
//  Selection-style controls (chips, onboarding options) use
//  .sensoryFeedback(.selection, trigger:) directly instead — see
//  OnboardingStatusPage and LogView.
//

import SwiftUI
import UIKit

struct HapticProminentButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            configuration.trigger()
        } label: {
            configuration.label
        }
        .buttonStyle(.borderedProminent)
    }
}

struct HapticPlainButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            configuration.trigger()
        } label: {
            configuration.label
        }
        .buttonStyle(.plain)
    }
}

extension PrimitiveButtonStyle where Self == HapticProminentButtonStyle {
    static var hapticProminent: HapticProminentButtonStyle { HapticProminentButtonStyle() }
}

extension PrimitiveButtonStyle where Self == HapticPlainButtonStyle {
    static var hapticPlain: HapticPlainButtonStyle { HapticPlainButtonStyle() }
}
