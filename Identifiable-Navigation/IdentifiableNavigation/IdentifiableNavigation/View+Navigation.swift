//

import SwiftUI

extension View {
  func navigation<V: Identifiable, Destination: View>(
    item: Binding<V?>,
    destination: @escaping (V) -> Destination
  ) -> some View {
    background(NavigationLink(item: item, destination: destination))
  }
}
