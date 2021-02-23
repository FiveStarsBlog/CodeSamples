//

import SwiftUI

struct ContentView: View {
  @State private var showingHUD = false

  var body: some View {
    NavigationView {
      VStack {
        Button("Show/hide HUD") {
          withAnimation {
            showingHUD.toggle()
          }
        }
      }
      .navigationTitle("Content View")
    }
    .hud(isPresented: $showingHUD) {
      Label("Five stars", systemImage: "star.fill")
    }
  }
}

extension View {
  func hud<Content: View>(
    isPresented: Binding<Bool>,
    @ViewBuilder content: () -> Content
  ) -> some View {
    ZStack(alignment: .top) {
      self
      if isPresented.wrappedValue {
        HUD(content: content)
          .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
          .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
              withAnimation {
                isPresented.wrappedValue = false
              }
            }
          }
          .zIndex(1)
      }
    }
  }
}

struct HUD<Content: View>: View {
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
