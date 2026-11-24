# DailyDrills

Read-only iOS browser for a 14-week coding curriculum bundled as `DailyDrills/curriculum.json`. Weeks → Days → Day detail. Persistence, completion tracking, search, notifications, widgets, networking and charts are intentionally out of scope for now (to be added by hand).

## Architecture
- SwiftUI, iOS 18.0+, iPhone + iPad only, Swift 6 mode, complete strict concurrency, zero-warning goal.
- `CurriculumLoader.loadBundled()` decodes the bundled JSON; `CurriculumStore` (`@Observable @MainActor`) loads once at init and is injected with `.environment(...)`. No singletons.
- `RootView` owns the `NavigationStack` and both `navigationDestination(for:)` registrations (`Week`, `DayTask`). Value-based navigation only.
- One view per file, each under ~150 lines. System fonts/colors only.

## Layout
- `DailyDrills/App`, `Models`, `Views`, `Problems` (LeetCode solutions, one file per problem).
- `DailyDrillsTests` uses Swift Testing (not XCTest) and is hosted by the app (needs the bundled JSON).

## Gotchas
- Model type `Link` shadows SwiftUI's `Link`; views must write `SwiftUI.Link`.
- `SWIFT_DEFAULT_ACTOR_ISOLATION` is `nonisolated` (not Xcode's MainActor default) so models decode off the main actor; the store is explicitly `@MainActor`.
- `ENABLE_DEBUG_DYLIB = NO` on the app: with it on, the hosted test bundle fails to link (symbols live in the debug dylib).
- The `DailyDrillsTests` scheme doesn't build the app first; build the `DailyDrills` scheme once before running tests from a clean state.

## Build / test
Build the `DailyDrills` scheme; run tests with the `DailyDrillsTests` scheme on an iPhone simulator.
