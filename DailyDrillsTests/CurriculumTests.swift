import Foundation
import Testing
@testable import DailyDrills

struct CurriculumTests {
    @Test func curriculumDecodes() throws {
        let curriculum = try CurriculumLoader.loadBundled()
        #expect(curriculum.weeks.count == 14)
        #expect(curriculum.weeks.allSatisfy { $0.days.count == 7 })
    }

    @Test func dayIDsAreUnique() throws {
        let ids = try CurriculumLoader.loadBundled().weeks.flatMap { $0.days.map(\.id) }
        #expect(Set(ids).count == ids.count)
    }

    @Test func weekDatesAreConsecutive() throws {
        let weeks = try CurriculumLoader.loadBundled().weeks
        let calendar = Calendar(identifier: .gregorian)
        for (previous, next) in zip(weeks, weeks.dropFirst()) {
            let start = try #require(DrillDate.date(from: previous.startDate))
            let following = try #require(DrillDate.date(from: next.startDate))
            let gap = calendar.dateComponents([.day], from: start, to: following).day
            #expect(gap == 7, "Week \(next.week) should start 7 days after week \(previous.week)")
        }
    }
}
