import Foundation

/// Helpers for the "yyyy-MM-dd" strings used throughout curriculum.json.
enum DrillDate {
    static func date(from string: String) -> Date? {
        let parts = string.split(separator: "-").compactMap { Int($0) }
        guard parts.count == 3 else { return nil }
        let components = DateComponents(year: parts[0], month: parts[1], day: parts[2])
        return Calendar(identifier: .gregorian).date(from: components)
    }

    static func shortText(_ string: String) -> String {
        guard let date = date(from: string) else { return string }
        return date.formatted(.dateTime.month(.abbreviated).day())
    }

    static func rangeText(start: String, end: String) -> String {
        "\(shortText(start)) – \(shortText(end))"
    }
}
