import SwiftUI

struct WeekRow: View {
    let week: Week

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Week \(week.week)")
                .font(.headline)
            Text(week.theme)
            Text(DrillDate.rangeText(start: week.startDate, end: week.endDate))
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}
