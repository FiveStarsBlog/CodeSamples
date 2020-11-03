//

import SwiftUI

struct ContentView: View {
  var backendString: String = "some backend string"

  var body: some View {
    let marketingText: Text =
      Text("Please please ").italic() +
      Text("tap me ") +
      Text("NOW!").underline().bold().font(.title)

    let exampleText: Text =
      Text("Default ") +
      Text("italic ").italic() +
      Text("Big ").font(.title) +
      Text("Red ").foregroundColor(.red) +
      Text("underline").underline()

    VStack {
      FSButton(titleKey: "my_localized_title") {}
      FSButton(backendString) {}
      FSButton(marketingText) {}
      FSButton(exampleText) {}
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .padding()
      .previewLayout(.sizeThatFits)
      .environment(\.locale, .init(identifier: "th"))
  }
}
