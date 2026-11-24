import SwiftUI

@main
struct DailyDrillsApp: App {
    @State private var store = CurriculumStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(store)
        }
    }
}
