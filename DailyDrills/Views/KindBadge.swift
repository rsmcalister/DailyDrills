import SwiftUI

struct KindBadge: View {
    let kind: DayTask.Kind

    var body: some View {
        Label(kind.title, systemImage: kind.symbol)
            .font(.caption.weight(.semibold))
            .foregroundStyle(kind.color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(kind.color.opacity(0.15), in: Capsule())
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("\(kind.title) task")
    }
}

extension DayTask.Kind {
    var title: String {
        switch self {
        case .setup: "Setup"
        case .leetcode: "LeetCode"
        case .ios: "iOS"
        case .livecoding: "Live coding"
        case .review: "Review"
        }
    }

    var symbol: String {
        switch self {
        case .setup: "hammer"
        case .leetcode: "function"
        case .ios: "iphone"
        case .livecoding: "timer"
        case .review: "cup.and.saucer"
        }
    }

    var color: Color {
        switch self {
        case .setup: .orange
        case .leetcode: .indigo
        case .ios: .blue
        case .livecoding: .red
        case .review: .brown
        }
    }
}
