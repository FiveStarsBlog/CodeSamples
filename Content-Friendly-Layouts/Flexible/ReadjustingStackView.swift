//

import SwiftUI

/// Facade of our view, its main responsibility is to get the available width
/// and pass it down to the real implementation, `_ReadjustingStackView`.
struct ReadjustingStackView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
  let data: Data
  let spacing: CGFloat
  let content: (Data.Element) -> Content
  @State private var availableWidth: CGFloat = 0

  var body: some View {
    ZStack {
      Color.clear
        .frame(height: 1)
        .readSize { size in
          availableWidth = size.width
        }

      _ReadjustingStackView(
        availableWidth: availableWidth,
        data: data,
        spacing: spacing,
        content: content
      )
    }
  }
}
