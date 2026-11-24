import SwiftUI

struct WeekDetailView: View {
    let week: Week

    var body: some View {
        List {
            Section("Days") {
                ForEach(week.days) { day in
                    NavigationLink(value: day) {
                        DayRow(day: day)
                    }
                }
            }
        }
        .navigationTitle(week.theme)
    }
}

#Preview {
    NavigationStack {
        if let week = CurriculumStore().weeks.first {
            WeekDetailView(week: week)
        }
    }
}
