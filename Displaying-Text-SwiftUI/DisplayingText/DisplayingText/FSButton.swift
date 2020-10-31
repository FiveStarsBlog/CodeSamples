//

import SwiftUI

struct FSButton: View {
  let title: Text
  let action: () -> Void

  init(_ title: Text, action: @escaping () -> Void) {
    self.title = title
    self.action = action
  }

  init<S: StringProtocol>(_ content: S, action: @escaping () -> Void) {
    self.title = Text(content)
    self.action = action
  }

  init(titleKey: LocalizedStringKey, tableName: String? = nil, bundle: Bundle? = nil, comment: StaticString? = nil, action: @escaping () -> Void) {
    self.title = Text(titleKey, tableName: tableName, bundle: bundle, comment: comment)
    self.action = action
  }

  var body: some View {
    Button(action: action, label: { title.bold() })
      .buttonStyle(FSButtonStyle())
  }
}

private struct FSButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
      configuration.label
        .foregroundColor(.white)
      Spacer()
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color.green)
    )
    .opacity(configuration.isPressed ? 0.5 : 1)
  }
}
