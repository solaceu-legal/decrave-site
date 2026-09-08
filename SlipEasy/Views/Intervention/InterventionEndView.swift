//
//  InterventionEndView.swift
//  SlipEasy
//

import SwiftUI

struct InterventionEndView: View {
    let tool: InterventionTool
    @Binding var path: [AppRoute]

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            // ScrollView + minHeight keeps this centered at normal text
            // sizes but lets it scroll instead of truncating this
            // sentence at max Dynamic Type — this text is the one place
            // in the app that must never get cut off.
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 24) {
                        Spacer(minLength: 0)

                        VStack(spacing: 12) {
                            Text(Strings.Intervention.endLine1)
                            Text(Strings.Intervention.endLine2)
                            Text(Strings.Intervention.endLine3)
                                .fontWeight(.semibold)
                        }
                        .font(.title3)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)

                        Spacer(minLength: 0)

                        VStack(spacing: 12) {
                            Button {
                                path.append(.log(outcome: .beaten, tool: tool))
                            } label: {
                                Text(Strings.Intervention.didntSmoke)
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.hapticProminent)
                            .controlSize(.large)

                            Button {
                                path.append(.log(outcome: .smoked, tool: tool))
                            } label: {
                                Text(Strings.Intervention.smoked)
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                            .buttonStyle(.hapticPlain)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                    }
                    .frame(minHeight: geometry.size.height)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        InterventionEndView(tool: .urgeSurfing, path: .constant([]))
    }
}
