//

import SwiftUI

extension NavigationLink where Label == EmptyView, Destination == AnyView {
  public init<V: Identifiable, Destination2: View>(
    item: Binding<V?>,
    destination: @escaping (V) -> Destination2
  ) {
    let value: V? = item.wrappedValue
    let isActive: Binding<Bool> = Binding(
      get: { item.wrappedValue != nil },
      set: { value in
        if !value {
          item.wrappedValue = nil
        }
      }
    )

    self.init(
      destination:
        AnyView(Group {
          if let value = value {
            destination(value)
          } else {
            EmptyView()
          }
        }),
      isActive: isActive,
      label: EmptyView.init
    )
  }
}
