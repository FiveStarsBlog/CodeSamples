//

import SwiftUI

struct ContentView: View {
  @State var isTruncated: Bool = false
  @State var forceFullText: Bool = false

  var body: some View {
    VStack {
      if forceFullText {
        text
          .fixedSize(horizontal: false, vertical: true)
      } else {
        TruncableText(
          text: text,
          lineLimit: 3
        ) {
          isTruncated = $0
        }
      }
      if isTruncated && !forceFullText {
        Button("show all") {
          forceFullText = true
        }
      }
    }
    .padding()
  }

  var text: Text {
    Text("Introducing a new kind of fitness experience. One that dynamically integrates your personal metrics from Apple Watch, along with music from your favorite artists, to inspire like no other workout in the world.")
  }
}

struct TruncableText: View {
  let text: Text
  let lineLimit: Int?
  @State private var intrinsicSize: CGSize = .zero
  @State private var truncatedSize: CGSize = .zero
  let isTruncatedUpdate: (_ isTruncated: Bool) -> Void

  var body: some View {
    text
      .lineLimit(lineLimit)
      .readSize { size in
        truncatedSize = size
        isTruncatedUpdate(truncatedSize != intrinsicSize)
      }
      .background(
        text
          .fixedSize(horizontal: false, vertical: true)
          .hidden()
          .readSize { size in
            intrinsicSize = size
            isTruncatedUpdate(truncatedSize != intrinsicSize)
          }
      )
  }
}

public extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
