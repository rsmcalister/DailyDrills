import Foundation

/// Parses and formats the "yyyy-MM-dd" strings used in curriculum.json.
enum DrillDate {
    private static var isoStyle: Date.ISO8601FormatStyle {
        Date.ISO8601FormatStyle(timeZone: .current).year().month().day()
    }

    static func parse(_ string: String) throws -> Date {
        try Date(string, strategy: isoStyle)
    }

    static func shortText(_ date: Date) -> String {
        date.formatted(.dateTime.month(.abbreviated).day())
    }

    static func rangeText(start: Date, end: Date) -> String {
        "\(shortText(start)) – \(shortText(end))"
    }
}
