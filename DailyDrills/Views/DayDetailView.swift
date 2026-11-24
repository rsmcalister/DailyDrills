import SwiftUI

struct DayDetailView: View {
    let day: DayTask
    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                if !day.study.topic.isEmpty || !day.study.searchHint.isEmpty {
                    DetailSection(title: "Study") {
                        Text(day.study.topic)
                        Text(day.study.searchHint)
                            .foregroundStyle(.secondary)
                    }
                }
                if !linkDestinations.isEmpty {
                    DetailSection(title: "Links") {
                        ForEach(linkDestinations, id: \.url) { item in
                            SwiftUI.Link(destination: item.url) {
                                Label(item.title, systemImage: "arrow.up.right.square")
                            }
                        }
                    }
                }
                if !day.description.isEmpty {
                    DetailSection(title: "What to build") {
                        Text(day.description)
                    }
                }
                states
                if !day.starterCode.isEmpty {
                    StarterCodeView(code: day.starterCode)
                }
                if !day.build.isEmpty || !day.buildStudyHint.isEmpty {
                    DetailSection(title: "Also today") {
                        if !day.build.isEmpty {
                            Text(day.build)
                        }
                        if !day.buildStudyHint.isEmpty {
                            Text(day.buildStudyHint)
                                .foregroundStyle(.secondary)
                        }
                    }
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
        if !day.startState.isEmpty || !day.endState.isEmpty {
            let layout = sizeClass == .regular
                ? AnyLayout(HStackLayout(alignment: .top, spacing: 12))
                : AnyLayout(VStackLayout(alignment: .leading, spacing: 12))
            layout {
                StateCard(title: "Start state", text: day.startState)
                StateCard(title: "End state", text: day.endState)
            }
        }
    }

    private var linkDestinations: [(title: String, url: URL)] {
        day.links.compactMap { link in
            URL(string: link.url).map { (link.title, $0) }
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
