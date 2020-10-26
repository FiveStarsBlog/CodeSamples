import SwiftUI

enum ContentViewGroup: Hashable {
  case a
  case b
  case c
}

struct ContentView: View {
  @State var showingContent: ContentViewGroup?

  var body: some View {
    List {
      DisclosureGroup(
        "Tap to show content A",
        tag: .a,
        selection: $showingContent) {
        Text("Content A")
      }

      DisclosureGroup(
        "Tap to show content B",
        tag: .b,
        selection: $showingContent) {
        Text("Content B")
      }

      DisclosureGroup(
        "Tap to show content C",
        tag: .c,
        selection: $showingContent) {
        Text("Content C")
      }
    }
  }
}

extension DisclosureGroup where Label == Text {
  public init<V: Hashable, S: StringProtocol>(
    _ label: S,
    tag: V,
    selection: Binding<V?>,
    content: @escaping () -> Content) {
    let boolBinding: Binding<Bool> = Binding(
      get: { selection.wrappedValue == tag },
      set: { newValue in
        if newValue {
          selection.wrappedValue = tag
        } else {
          selection.wrappedValue = nil
        }
      }
    )

    self.init(
      label,
      isExpanded: boolBinding,
      content: content
    )
  }
}
