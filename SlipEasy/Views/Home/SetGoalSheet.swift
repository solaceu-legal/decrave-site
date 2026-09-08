//
//  SetGoalSheet.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

struct SetGoalSheet: View {
    let plan: ReductionPlan?
    let onSave: () -> Void

    @Environment(\.modelContext) private var modelContext
    @AppStorage("cigsPerDay") private var cigsPerDayStored: Int = 10

    @State private var target: Double = 10

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 0)

                    Text(Strings.ReductionGoal.goalQuestion)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)

                    Text("\(Int(target))")
                        .font(.system(size: 56, weight: .bold, design: .rounded))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)

                    Slider(value: $target, in: 1...40, step: 1)
                        .padding(.horizontal, 32)

                    Spacer(minLength: 0)

                    Button(action: save) {
                        Text(Strings.ReductionGoal.goalSave)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.hapticProminent)
                    .controlSize(.large)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 24)
                }
                .frame(minHeight: geometry.size.height)
            }
        }
        .background(Color.appBackground.ignoresSafeArea())
        .onAppear {
            target = Double(plan?.targetCigsPerDay ?? cigsPerDayStored)
        }
    }

    private func save() {
        let record: ReductionPlan
        if let plan {
            record = plan
        } else {
            record = ReductionPlan()
            modelContext.insert(record)
        }
        record.targetCigsPerDay = Int(target)
        record.targetSetDate = Date()
        onSave()
    }
}

#Preview {
    SetGoalSheet(plan: nil, onSave: {})
        .modelContainer(for: ReductionPlan.self, inMemory: true)
}
