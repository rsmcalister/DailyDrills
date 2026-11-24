import Foundation
import Observation

@Observable
@MainActor
final class CurriculumStore {
    private(set) var weeks: [Week] = []
    private(set) var loadError: String?

    init(load: () throws -> Curriculum = CurriculumLoader.loadBundled) {
        do {
            weeks = try load().weeks
        } catch {
            loadError = error.localizedDescription
        }
    }
}
