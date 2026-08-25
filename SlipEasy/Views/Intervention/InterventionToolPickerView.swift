//
//  InterventionToolPickerView.swift
//  SlipEasy
//

import SwiftUI

/// Same equal-weight card pattern as OnboardingStatusPage — neither tool
/// gets a "recommended" badge or visual priority.
struct InterventionToolPickerView: View {
    @Binding var path: [AppRoute]

    @State private var selectedTool: InterventionTool?

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 0)

                    Text(Strings.Intervention.toolPickerQuestion)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)

                    VStack(spacing: 12) {
                        toolCard(.urgeSurfing)
                        toolCard(.breathing)
                    }
                    .padding(.horizontal, 24)

                    Spacer(minLength: 0)
                }
                .frame(minHeight: geometry.size.height)
            }
        }
        .sensoryFeedback(.selection, trigger: selectedTool)
    }

    private func toolCard(_ tool: InterventionTool) -> some View {
        Button {
            selectedTool = tool
            path.append(.intervention(tool: tool))
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                Text(tool.title)
                    .font(.body)
                    .fontWeight(.semibold)
                Text(tool.subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
        .foregroundStyle(Color.primary)
    }
}

#Preview {
    NavigationStack {
        InterventionToolPickerView(path: .constant([]))
    }
}
