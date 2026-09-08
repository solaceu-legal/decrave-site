//
//  QuitDatePickerSheet.swift
//  SlipEasy
//

import SwiftUI

struct QuitDatePickerSheet: View {
    let plan: ReductionPlan
    let onSave: () -> Void

    @State private var selectedDate: Date = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()

    var body: some View {
        VStack(spacing: 24) {
            Text(Strings.ReductionGoal.quitDateQuestion)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 24)

            DatePicker(
                "",
                selection: $selectedDate,
                in: Date()...,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .labelsHidden()
            .padding(.horizontal, 24)

            Spacer()

            Button(action: save) {
                Text(Strings.ReductionGoal.quitDateSave)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.hapticProminent)
            .controlSize(.large)
            .padding(.horizontal, 32)
            .padding(.bottom, 24)
        }
        .background(Color.appBackground.ignoresSafeArea())
    }

    private func save() {
        plan.quitDate = selectedDate
        onSave()
    }
}

#Preview {
    QuitDatePickerSheet(plan: ReductionPlan(), onSave: {})
}
