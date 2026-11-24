import Foundation

struct Curriculum: Decodable, Sendable {
    let app: String
    let version: Int
    let weeks: [Week]
}

struct Week: Decodable, Identifiable, Hashable, Sendable {
    var id: Int { week }
    let week: Int
    let startDate: Date
    let endDate: Date
    let theme: String
    let days: [DayTask]
}

struct DayTask: Decodable, Identifiable, Hashable, Sendable {
    let id: String
    let date: Date
    let weekday: String
    let kind: Kind
    let title: String
    let study: Study
    let links: [Link]
    let description: String
    let startState: String
    let endState: String
    let starterCode: String
    let minutes: Int
    let build: String
    let buildStudyHint: String

    enum Kind: String, Decodable, Sendable {
        case setup, leetcode, ios, livecoding, review
    }
}

struct Study: Decodable, Hashable, Sendable {
    let topic: String
    let searchHint: String
}

struct Link: Decodable, Hashable, Sendable {
    let title: String
    let url: URL
}

extension DayTask {
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    var dateString: String {
        return formatter.string(from: date)
    }

}
