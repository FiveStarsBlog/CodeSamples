//

import SwiftUI

enum ContentViewNavigation: Identifiable {
  case one
  case two(number: Int)
  case three(text: String)

  // MARK: Identifiable

  var id: Int {
    switch self {
    case .one:
      return 1
    case .two:
      return 2
    case .three:
      return 3
    }
  }
}

struct ContentView: View {
  @State private var showingNavigation: ContentViewNavigation?

  var body: some View {
    NavigationView {
      VStack {
        Button("Go to navigation one") {
          showingNavigation = .one
        }
        Button("Go to navigation two") {
          showingNavigation = .two(number: Int.random(in: 1...5))
        }
        Button("Go to navigation three") {
          showingNavigation = .three(text: ["five", "stars"].randomElement()!)
        }
      }
      .navigation(item: $showingNavigation, destination: presentNavigation)
    }
  }

  @ViewBuilder
  func presentNavigation(_ navigation: ContentViewNavigation) -> some View {
    switch navigation {
    case .one:
      Text(verbatim: "one")
    case .two(let number):
      Text("two \(number)")
    case .three(let text):
      Text("three \(text)")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
