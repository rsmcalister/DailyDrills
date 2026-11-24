import SwiftUI

struct WeeksView: View {
    @Environment(CurriculumStore.self) private var store

    var body: some View {
        List(store.weeks) { week in
            NavigationLink(value: week) {
                WeekRow(week: week)
            }
        }
        .navigationTitle("DailyDrills")
    }
}
