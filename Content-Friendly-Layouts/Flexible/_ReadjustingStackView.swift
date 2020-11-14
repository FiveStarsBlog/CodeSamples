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
        contentGroup
      }
    } else {
      VStack(spacing: spacing) {
        contentGroup
      }
    }
  }

  var contentGroup: some View {
    ForEach(data, id: \.self) { element in
      content(element)
        .fixedSize()
        .readSize { size in
          elementsSize[element] = size
        }
    }
  }

  func isHorizontal() -> Bool {
    var remainingWidth = availableWidth

    for element in data {
      let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
      remainingWidth = remainingWidth - (elementSize.width + spacing)

      if remainingWidth < 0 {
        return false
      }
    }
    return true
  }
}
