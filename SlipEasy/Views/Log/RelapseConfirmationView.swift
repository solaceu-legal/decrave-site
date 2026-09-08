//
//  RelapseConfirmationView.swift
//  SlipEasy
//

import SwiftUI
import SwiftData

/// Required screen after "I smoked" — must actively reaffirm the count
/// stands, not just fail to decrement it. No "failed / relapse / start
/// over" wording here, ever.
struct RelapseConfirmationView: View {
    @Binding var path: [AppRoute]

    @Query(filter: #Predicate<CravingLog> { $0.outcomeRaw == "beaten" })
    private var beatenLogs: [CravingLog]

    var body: some View {
        // ScrollView + minHeight: centered at normal text sizes, scrolls
        // instead of truncating at max Dynamic Type (see InterventionEndView).
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 0)

                    Text(Strings.Relapse.logged)
                        .font(.title2)
                        .fontWeight(.bold)

                    VStack(spacing: 8) {
                        Text(Strings.Relapse.winsStillCount(beatenLogs.count))
                            .font(.title3)
                        Text(Strings.Relapse.neverReset)
                            .foregroundStyle(.secondary)
                    }
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                    Spacer(minLength: 0)

                    Button {
                        path.removeAll()
                    } label: {
                        Text(Strings.Relapse.back)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.hapticProminent)
                    .controlSize(.large)
                    .padding(.horizontal, 24)
                    // This screen is reached both from SOSFlowView's
                    // fullScreenCover (no tab bar below it) and from the
                    // You tab's own NavigationStack (pushed under the
                    // persistent tab bar + floating FAB) — see
                    // AppRoute.relapseConfirmation's two call sites. Using
                    // the same clearance as the tab screens keeps this
                    // button clear of the FAB in the latter case; in the
                    // former it's just some extra breathing room above the
                    // home indicator.
                    .padding(.bottom, Layout.tabBarClearance)
                }
                .frame(minHeight: geometry.size.height)
            }
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        RelapseConfirmationView(path: .constant([]))
    }
    .modelContainer(for: CravingLog.self, inMemory: true)
}
