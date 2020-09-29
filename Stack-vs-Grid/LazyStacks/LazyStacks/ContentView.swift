//

import SwiftUI

struct ContentView: View {
  var body: some View {
    HStack {
      ScrollView {
        LazyVStack(
          alignment: .leading,
          spacing: 20,
          pinnedViews: [.sectionHeaders]
        ) {
          Section(header: header(title: "Original")) { content }
        }
      }
      ScrollView {
        LazyVStackMock(
          alignment: .leading,
          spacing: 20,
          pinnedViews: [.sectionHeaders]
        ) {
          Section(header: header(title: "Mock")) { content }
        }
      }
    }
    .font(.title)
  }

  var content: some View {
    ForEach(1...40, id: \.self) { count in
      Label("Placeholder \(count)", colorfulSystemImage: "leaf.fill")
    }
  }

  func header(title: String) -> some View {
    Text(verbatim: title)
      .bold()
      .padding(.horizontal)
      .padding(.vertical, 4)
      .foregroundColor(.white)
      .background(
        Capsule().foregroundColor(.green)
      )
  }
}
