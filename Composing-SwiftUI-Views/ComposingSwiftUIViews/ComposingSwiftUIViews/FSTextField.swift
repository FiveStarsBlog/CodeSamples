//

import SwiftUI

struct FSTextField<TopContent: View>: View {
  var placeholder: LocalizedStringKey = "Placeholder"
  @Binding var text: String
  var appearance: Appearance = .default
  var topContent: TopContent

  init(
    placeholder: LocalizedStringKey = "",
    text: Binding<String>,
    appearance: Appearance = .default,
    @ViewBuilder topContent: () -> TopContent
  ) {
    self.placeholder = placeholder
    self._text = text
    self.appearance = appearance
    self.topContent = topContent()
  }

  enum Appearance {
    case `default`
    case error
  }
  
  var body: some View {
    VStack {
      topContent
      _FSTextField(
        placeholder: placeholder,
        text: $text,
        borderColor: borderColor
      )
    }
  }

  var borderColor: Color {
    switch appearance {
    case .default:
      return .green
    case .error:
      return .red
    }
  }
}


extension FSTextField where TopContent == EmptyView {
  init(
    placeholder: LocalizedStringKey = "",
    text: Binding<String>,
    appearance: Appearance = .default
  ) {
    self.placeholder = placeholder
    self._text = text
    self.appearance = appearance
    self.topContent = EmptyView()
  }
}

extension FSTextField {
  init<TopTrailingContent: View>(
    title: LocalizedStringKey,
    placeholder: LocalizedStringKey = "",
    text: Binding<String>,
    appearance: Appearance = .default,
    @ViewBuilder topTrailingContent: () -> TopTrailingContent
  ) where TopContent == HStack<TupleView<(Text, Spacer, TopTrailingContent)>> {
    self.placeholder = placeholder
    self._text = text
    self.appearance = appearance
    self.topContent = {
      HStack {
        Text(title)
          .bold()
        Spacer()
        topTrailingContent()
      }
    }()
  }
}

extension FSTextField {
  init(
    title: LocalizedStringKey,
    placeholder: LocalizedStringKey = "",
    text: Binding<String>,
    appearance: Appearance = .default
  ) where TopContent == HStack<TupleView<(Text, Spacer, EmptyView)>> {
    self.init(
      title: title,
      placeholder: placeholder,
      text: text,
      appearance: appearance,
      topTrailingContent: EmptyView.init
    )
  }
}

struct FSTextField_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      FSTextField(
        placeholder: "Placeholder",
        text: .constant("")
      ) {
        Text("Title Centered")
          .bold()
      }

      FSTextField(
        placeholder: "Placeholder",
        text: .constant("")
      )

      FSTextField(
        title: "Title",
        text: .constant(""),
        topTrailingContent: {
        Text("Message")
          .font(.caption)
      })
    }
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
