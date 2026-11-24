import SwiftUI

struct DayRow: View {
    let day: DayTask

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("\(day.weekday) · \(DrillDate.shortText(day.date))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                KindBadge(kind: day.kind)
            }
            Text(day.title)
                .font(.headline)
        }
    }
}
