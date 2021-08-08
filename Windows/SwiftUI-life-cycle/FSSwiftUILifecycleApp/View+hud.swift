import SwiftUI

extension View {
  func hud<Content: View>(
    isPresented: Binding<Bool>,
    @ViewBuilder content: () -> Content
  ) -> some View {
    overlay(alignment: .top) {
      HUD(content: content)
        .onTapGesture {
            isPresented.wrappedValue = false
        }
        .offset(y: isPresented.wrappedValue ? 0 : -128)
        .animation(Animation.spring(), value: isPresented.wrappedValue)
    }
  }
}

private struct HUD<Content: View>: View {
  @ViewBuilder let content: Content

  var body: some View {
    content
      .padding(.horizontal, 12)
      .padding(16)
      .background(
        Capsule()
          .foregroundColor(Color.white)
          .shadow(color: Color(.black).opacity(0.16), radius: 12, x: 0, y: 5)
      )
  }
}
