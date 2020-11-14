//

import SwiftUI

/// This view is responsible to lay down the given elements and wrap them into
/// multiple rows if needed.
struct _ReadjustingStackView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
  let availableWidth: CGFloat
  let data: Data
  let spacing: CGFloat
  let content: (Data.Element) -> Content
  @State var elementsSize: [Data.Element: CGSize] = [:]

  var body : some View {
    if isHorizontal() {
      HStack(spacing: spacing) {
        elementsViews
      }
    } else {
      VStack(spacing: spacing) {
        elementsViews
      }
    }
  }

  var elementsViews: some View {
    ForEach(data, id: \.self) { element in
      content(element)
        .fixedSize()
        .readSize { size in
          elementsSize[element] = size
        }
    }
  }

  func isHorizontal() -> Bool {
    let desiredStackViewWidth = data.reduce(into: 0) { totalWidth, element in
      let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
      totalWidth += elementSize.width
    } + CGFloat(data.count - 1) * spacing

    return availableWidth >= desiredStackViewWidth
  }
}
