import SwiftUI
import SwiftData

@main
struct DailyDrillsApp: App {
    @State private var store = CurriculumStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(store)
        }
        .modelContainer(for: TaskProgress.self)
    }
}
