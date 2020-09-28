//

import SwiftUI

public struct LazyVStackMock<Content: View>: View {
  let alignment: HorizontalAlignment
  let spacing: CGFloat?
  let pinnedViews: PinnedScrollableViews
  let content: Content

  public init(
    alignment: HorizontalAlignment = .center,
    spacing: CGFloat? = nil,
    pinnedViews: PinnedScrollableViews = .init(),
    @ViewBuilder content: () -> Content
  ) {
    self.alignment = alignment
    self.spacing = spacing
    self.pinnedViews = pinnedViews
    self.content = content()
  }

  public var body: some View {
    LazyVGrid(
      columns: [GridItem(.flexible())],
      alignment: alignment,
      spacing: spacing,
      pinnedViews: pinnedViews,
      content: { content }
    )
  }
}
