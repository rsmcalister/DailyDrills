import SwiftUI

struct RootView: View {
    @Environment(CurriculumStore.self) private var store

    var body: some View {
        if let message = store.loadError {
            ContentUnavailableView(
                "Couldn't Load Curriculum",
                systemImage: "exclamationmark.triangle",
                description: Text(message)
            )
        } else {
            NavigationStack {
                WeeksView()
                    .navigationDestination(for: Week.self) { week in
                        WeekDetailView(week: week)
                    }
                    .navigationDestination(for: DayTask.self) { day in
                        DayDetailView(day: day)
                    }
            }
        }
    }
}

#Preview {
    RootView()
        .environment(CurriculumStore())
}
