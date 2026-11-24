import SwiftUI
import SwiftData

struct DayDetailView: View {
    let day: DayTask

    @Environment(\.horizontalSizeClass) private var sizeClass
    @Environment(\.modelContext) private var modelContext
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
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                if day.study.topic.isNotEmpty || day.study.searchHint.isNotEmpty {
                    DetailSection(title: "Study") {
                        Text(day.study.topic)
                        Text(day.study.searchHint)
                            .foregroundStyle(.secondary)
                    }
                }
                if day.links.isNotEmpty {
                    DetailSection(title: "Links") {
                        ForEach(day.links, id: \.url) { link in
                            SwiftUI.Link(destination: link.url) {
                                Label(link.title, systemImage: "arrow.up.right.square")
                            }
                        }
                    }
                }
                if day.description.isNotEmpty {
                    DetailSection(title: "What to build") {
                        Text(day.description)
                    }
                }
                states
                if day.starterCode.isNotEmpty {
                    StarterCodeView(code: day.starterCode)
                }
                if day.build.isNotEmpty || day.buildStudyHint.isNotEmpty {
                    DetailSection(title: "Also today") {
                        if day.build.isNotEmpty {
                            Text(day.build)
                        }
                        if day.buildStudyHint.isNotEmpty {
                            Text(day.buildStudyHint)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                HStack {
                    Spacer()
                    Button(isDone ? "Completed" : "Mark Complete") {
                        markComplete()
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                }
            }
            .padding()
        }
        .navigationTitle(DrillDate.shortText(day.date))
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(day.title)
                .font(.title.bold())
            ViewThatFits(in: .horizontal) {
                HStack(spacing: 12) { headerDetails }
                VStack(alignment: .leading, spacing: 8) { headerDetails }
            }
        }
    }

    @ViewBuilder
    private var headerDetails: some View {
        KindBadge(kind: day.kind)
        Text("\(day.weekday) · \(DrillDate.shortText(day.date))")
        Text("≈ \(day.minutes) min")
    }

    @ViewBuilder
    private var states: some View {
        if day.startState.isNotEmpty || day.endState.isNotEmpty {
            let layout = sizeClass == .regular
                ? AnyLayout(HStackLayout(alignment: .top, spacing: 12))
                : AnyLayout(VStackLayout(alignment: .leading, spacing: 12))
            layout {
                if day.startState.isNotEmpty {
                    StateCard(title: "Start state", text: day.startState)
                }
                if day.endState.isNotEmpty {
                    StateCard(title: "End state", text: day.endState)
                }
            }
        }
    }

    func markComplete() {
        if let taskProgress {
            modelContext.delete(taskProgress)
        } else {
            let task = TaskProgress(taskID: day.dateString, isDone: true)
            modelContext.insert(task)
        }
    }
}

#Preview {
    NavigationStack {
        if let day = CurriculumStore().weeks.first?.days.first {
            DayDetailView(day: day)
        }
    }
}
