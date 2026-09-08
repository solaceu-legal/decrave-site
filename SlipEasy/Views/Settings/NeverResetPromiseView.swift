//
//  NeverResetPromiseView.swift
//  SlipEasy
//
//  Reached from a tappable row in Settings — pure explainer copy, no
//  logic. Point 3 is deliberately reworded from Decrave's "every slip
//  makes the plan smarter" (that implied a pattern-learning feature
//  SlipEasy doesn't have) into something the app actually does today.
//

import SwiftUI

struct NeverResetPromiseView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(Strings.Settings.promiseHeading)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(Strings.Settings.promiseIntro)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    promisePoint(number: "1", title: Strings.Settings.promisePoint1Title, body: Strings.Settings.promisePoint1Body)
                    promisePoint(number: "2", title: Strings.Settings.promisePoint2Title, body: Strings.Settings.promisePoint2Body)
                    promisePoint(number: "3", title: Strings.Settings.promisePoint3Title, body: Strings.Settings.promisePoint3Body)
                }
                .padding(24)
            }
            .background(Color.appBackground.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(.hapticPlain)
                }
            }
        }
    }

    private func promisePoint(number: String, title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(number) · \(title)")
                .font(.subheadline)
                .fontWeight(.bold)
            Text(body)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}

#Preview {
    NeverResetPromiseView()
}
