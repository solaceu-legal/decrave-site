//
//  OnboardingPageIndicator.swift
//  SlipEasy
//

import SwiftUI

struct OnboardingPageIndicator: View {
    let current: Int
    let total: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \.self) { index in
                Circle()
                    .fill(index == current ? Color.primary : Color.secondary.opacity(0.3))
                    .frame(width: 7, height: 7)
            }
        }
    }
}

#Preview {
    OnboardingPageIndicator(current: 1, total: 3)
}
