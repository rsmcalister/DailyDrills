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
        let calendar = Calendar.current
        for (previous, next) in zip(weeks, weeks.dropFirst()) {
            let gap = calendar.dateComponents([.day], from: previous.startDate, to: next.startDate).day
            #expect(gap == 7, "Week \(next.week) should start 7 days after week \(previous.week)")
        }
    }

    @Test func parsesDayAsLocalCalendarDate() throws {
        let date = try DrillDate.parse("2026-11-23")
        let parts = Calendar.current.dateComponents([.year, .month, .day], from: date)
        #expect(parts.year == 2026 && parts.month == 11 && parts.day == 23)
    }
}
