//
//  HomeView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Binding var path: [AppRoute]

    @Query(
        filter: #Predicate<CravingLog> { $0.outcomeRaw == "beaten" },
        sort: \CravingLog.timestamp
    )
    private var beatenLogs: [CravingLog]

    // Scales with Dynamic Type instead of a fixed point size, while still
    // starting well above the ≥72pt the design calls for.
    @ScaledMetric(relativeTo: .largeTitle) private var numberSize: CGFloat = 88

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            VStack(spacing: 4) {
                Text("\(beatenLogs.count)")
                    .font(.system(size: numberSize, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.primary)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                Text(Strings.Home.cravingsBeaten)
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(spacing: 8) {
                Text(Strings.Home.last7Days)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                WeeklyBarsView(logs: beatenLogs)
            }

            Spacer()

            VStack(spacing: 12) {
                Button {
                    path.append(.intervention)
                } label: {
                    Text("\(Strings.Home.wantToSmoke) 🔥")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.hapticProminent)
                .controlSize(.large)

                Button {
                    path.append(.log(outcome: .smoked))
                } label: {
                    Text(Strings.Home.iSmoked)
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.hapticPlain)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView(path: .constant([]))
    }
    .modelContainer(for: CravingLog.self, inMemory: true)
}
