//

import SwiftUI

// MARK: Size class

// Run this on a plus size device in landscape or on an iPad to see the regular
// size class.

/*
struct AdaptiveView<Content: View>: View {
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  var content: Content

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    if horizontalSizeClass == .regular {
      HStack {
        content
      }
    } else {
      VStack {
        content
      }
    }
  }
}
*/

// MARK: Dynamic Type

// Change the system dynamic type to switch between layouts.

/*
struct AdaptiveView<Content: View>: View {
  @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
  var content: Content

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    if sizeCategory.isAccessibilityCategory {
      VStack {
        content
      }
    } else {
      HStack {
        content
      }
    }
  }
}
*/

// MARK: Custom threshold

struct AdaptiveView<Content: View>: View {
  @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory

  @State private var availableWidth: CGFloat = 0
  var threshold: CGFloat
  var content: Content

  public init(threshold: CGFloat = 500, @ViewBuilder content: () -> Content) {
    self.threshold = threshold
    self.content = content()
  }

  var body: some View {
    ZStack {
      Color.clear
        .frame(height: 1)
        .readSize { size in
          availableWidth = size.width
        }

      if availableWidth > threshold {
        HStack {
          content
        }
      } else {
        VStack {
          content
        }
      }
    }
  }
}
