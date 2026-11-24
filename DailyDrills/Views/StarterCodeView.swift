import SwiftUI
import UIKit

struct StarterCodeView: View {
    let code: String
    @State private var didCopy = false

    var body: some View {
        DetailSection(title: "Starter code") {
            ScrollView(.horizontal) {
                Text(code)
                    .font(.system(.body, design: .monospaced))
                    .textSelection(.enabled)
                    .fixedSize(horizontal: true, vertical: true)
                    .padding()
            }
            .background(.fill.tertiary, in: .rect(cornerRadius: 12))

            Button(action: copy) {
                Label(didCopy ? "Copied" : "Copy", systemImage: didCopy ? "checkmark" : "doc.on.doc")
            }
            .buttonStyle(.bordered)
            .accessibilityLabel(didCopy ? "Copied starter code" : "Copy starter code")
        }
        .task(id: didCopy) {
            guard didCopy else { return }
            try? await Task.sleep(for: .seconds(1.5))
            didCopy = false
        }
    }

    private func copy() {
        UIPasteboard.general.string = code
        didCopy = true
    }
}
