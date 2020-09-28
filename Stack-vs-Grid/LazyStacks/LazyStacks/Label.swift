//

import SwiftUI

extension Label where Title == Text, Icon == Image {
  init(_ title: LocalizedStringKey, colorfulSystemImage systemImage: String) {
    self.init {
      Text(title)
    } icon: {
      Image(systemName: systemImage)
        .renderingMode(.original)
    }
  }
}
