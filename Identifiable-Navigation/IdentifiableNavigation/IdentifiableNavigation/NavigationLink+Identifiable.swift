//

import SwiftUI

extension NavigationLink where Label == EmptyView {
  public init?<V: Identifiable>(
    item: Binding<V?>,
    destination: @escaping (V) -> Destination
  ) {
    if let value = item.wrappedValue {
      let isActive: Binding<Bool> = Binding(
        get: { item.wrappedValue != nil },
        set: { value in
          if !value {
            item.wrappedValue = nil
          }
        }
      )

      self.init(
        destination: destination(value),
        isActive: isActive,
        label: EmptyView.init
      )
    } else {
      return nil
    }
  }
}
