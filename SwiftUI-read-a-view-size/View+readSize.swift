// Original article here: https://fivestars.blog/articles/swiftui-share-layout-information/

import SwiftUI

/*

Example:

var body: some View {
  childView
    .readSize { newSize in
      print("The new child size is: \(newSize)")
    }
}

*/

extension View {
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