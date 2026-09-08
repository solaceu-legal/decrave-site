//
//  MomentumRingView.swift
//  SlipEasy
//
//  Visualizes InsightsEngine.momentumScore — a small ring, not a hero
//  number, since the two numbers that should dominate Home are the ones
//  that never reset (cravings beaten, money saved). This one can dip.
//

import SwiftUI

struct MomentumRingView: View {
    let score: Int

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.1), lineWidth: 6)
            Circle()
                .trim(from: 0, to: CGFloat(score) / 100)
                .stroke(LinearGradient.brand, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.6), value: score)
            Text("\(score)")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(Color.primary)
                .minimumScaleFactor(0.6)
        }
        .frame(width: 56, height: 56)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Strings.Home.momentumLabel)
        .accessibilityValue("\(score)")
    }
}

#Preview {
    MomentumRingView(score: 72)
        .padding()
        .background(Color.appBackground)
}
