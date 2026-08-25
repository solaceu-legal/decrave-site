//
//  WeeklyReportView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

struct WeeklyReportView: View {
    @Query(sort: \CravingLog.timestamp) private var allLogs: [CravingLog]

    // Same "last 7 days including today" window as WeeklyBarsView on Home,
    // computed the same way (filter in Swift, not a dynamic SwiftData
    // predicate) for consistency with the rest of the app.
    private var weekLogs: [CravingLog] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        guard let windowStart = calendar.date(byAdding: .day, value: -6, to: today) else { return [] }
        return allLogs.filter { $0.timestamp >= windowStart }
    }

    private var winsThisWeek: Int {
        weekLogs.filter { $0.outcome == .beaten }.count
    }

    var body: some View {
        ProGatedView(lockedBody: Strings.Report.lockedBody) {
            reportBody
        }
    }

    private var reportBody: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text(Strings.Report.title)
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)

            Text(Strings.Report.winsThisWeek(winsThisWeek))
                .font(.title3)
                .fontWeight(.semibold)

            VStack(alignment: .leading, spacing: 8) {
                Text(Strings.Report.peakHoursTitle)
                    .font(.headline)
                PeakHoursChart(logs: weekLogs)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(Strings.Report.topTriggersTitle)
                    .font(.headline)
                TopTriggersChart(logs: weekLogs)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
        .padding(.bottom, 24)
    }
}

#Preview {
    NavigationStack {
        WeeklyReportView()
    }
    .modelContainer(for: CravingLog.self, inMemory: true)
}
