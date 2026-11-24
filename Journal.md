# DailyDrills Journal

## The Big Picture
DailyDrills is a pocket coach. A 14-week job-hunt-and-practice plan lives in one JSON file, and the app lets you flip through it: pick a week, pick a day, see what to study, what to build, and grab the starter code. Today it only *reads* the plan. Think of it as the printed schedule taped to the fridge, before anyone adds checkboxes.

## Architecture Deep Dive
Picture a small restaurant. `curriculum.json` is the pantry. `CurriculumLoader` is the delivery driver who brings the ingredients in once. `CurriculumStore` is the head chef who keeps them on the counter (`weeks`), and notes if the delivery failed (`loadError`). The views are waiters: they never cook, they just carry what's on the counter to the table. `RootView` is the host who decides whether to seat you (the list) or apologise (the error screen), and who knows which door each tap leads through (`navigationDestination`).

## The Codebase Map
- `App/DailyDrillsApp.swift`: entry point; creates the store and injects it.
- `Models/`: `Curriculum.swift` (data types), `CurriculumLoader`, `CurriculumStore`, `DrillDate` (date-string helpers).
- `Views/`: `RootView`, `WeeksView` + `WeekRow`, `WeekDetailView` + `DayRow`, `DayDetailView` and its helpers (`KindBadge`, `DetailSection`, `StateCard`, `StarterCodeView`).
- `Problems/`: empty on purpose; LeetCode solutions go here.
- `DailyDrillsTests/`: Swift Testing checks on the JSON itself.

## Tech Stack & Why
- **SwiftUI + NavigationStack with values**: later features (deep links, a Today screen) want navigation that's data, not views.
- **@Observable**: less ceremony than ObservableObject, no Combine.
- **Swift 6 + complete concurrency**: catches data races at compile time while the codebase is tiny and cheap to fix.
- **Swift Testing**: the modern default; `#expect` reads like English.

## The Journey

### 2026-11-23
- **The Great Name Clash.** The spec's model is called `Link`... and SwiftUI has a `Link` view. The compiler answered `Link(destination:)` with a baffling "extra arguments" error because it was looking at *our* struct. Fix: write `SwiftUI.Link`. Lesson: when an error makes no sense, ask "which type is it actually looking at?"
- **Files in the wrong house.** The Xcode tools resolve paths from the project root, so my first folders landed beside the app folder instead of inside it. Moved them with `XcodeMV` and checked with `find`. Lesson: verify where files really land, not where you meant them to.
- **Tests that wouldn't link.** The hosted test bundle couldn't find the app's symbols because Debug builds hide code in a `.debug.dylib`. Turning off `ENABLE_DEBUG_DYLIB` fixed it. Also: the test scheme doesn't rebuild the app, so a stale app binary gave the same error again until I built the app scheme.
- **Dates are sneaky.** Parsing "2026-11-23" as UTC and displaying in local time shifts the day for anyone west of Greenwich. `DrillDate` builds dates from year/month/day components instead.

## Engineer's Wisdom
- Make the loader injectable (the store takes a closure) so failure states are easy to preview and test.
- Small views in their own files stay readable and are easy to replace when you hand-write the next feature.
- Tests that validate *data* (unique IDs, consecutive weeks) catch content typos before users do.

## If I Were Starting Over...
- Create folders with `XcodeMakeDir` and check paths first.
- Decide the actor-isolation default up front; Xcode's new MainActor default and Decodable models don't mix without thought.
- Add a target dependency so the test scheme builds the app automatically.
