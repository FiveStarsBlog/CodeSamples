//

import SwiftUI

@main
struct FiveStarsApp: App {
  @StateObject var hudState = HUDState()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .hud(isPresented: $hudState.isPresented) {
          Label(hudState.title, systemImage: hudState.systemImage)
        }
        .environmentObject(hudState)
    }
  }
}

final class HUDState: ObservableObject {
  @Published var isPresented: Bool = false
  private(set) var title: String = ""
  private(set) var systemImage: String = ""

  func show(title: String, systemImage: String) {
    self.title = title
    self.systemImage = systemImage
    withAnimation {
      isPresented = true
    }
  }
}

struct ContentView: View {
  @EnvironmentObject private var hud: HUDState

  var body: some View {
    NavigationView {
      Button("Show/hide HUD") {
        hud.show(title: "Five stars", systemImage: "star.fill")
      }
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
