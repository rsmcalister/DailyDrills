import SwiftUI

struct StateCard: View {
    let title: String
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
            Text(text)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(.fill.tertiary, in: .rect(cornerRadius: 12))
        .accessibilityElement(children: .combine)
    }
}
