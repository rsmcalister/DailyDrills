import SwiftUI
import SwiftData

struct DayRow: View {
    let day: DayTask
    @Query var progress: [TaskProgress]
    var taskProgress: TaskProgress? {
        progress.filter({ $0.taskID == day.dateString }).first
    }
    var isDone: Bool {
        if let _ = taskProgress {
            return true
        }
        return false
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("\(day.weekday) · \(DrillDate.shortText(day.date))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                KindBadge(kind: day.kind)
            }
            HStack {
                if isDone {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
                Text(day.title)
                    .font(.headline)
            }
        }
    }
}
