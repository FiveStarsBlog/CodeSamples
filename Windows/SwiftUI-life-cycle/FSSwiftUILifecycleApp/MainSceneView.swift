import SwiftUI

struct MainSceneView: View {
  @EnvironmentObject var sceneDelegate: FSSceneDelegate
  @EnvironmentObject var hudState: HudState
  @State var showingSheet = false

  var body: some View {
    NavigationView {
      VStack {
        Button("Show hud") {
          hudState.show(title: "Five Stars", systemImage: "star.fill")
        }

        Button("Show sheet") {
          showingSheet = true
        }
      }
    }
    .font(.largeTitle)
    .frame(maxWidth: .infinity)
    .sheet(isPresented: $showingSheet) {
      Text("Sheet")
    }
    .onAppear {
      sceneDelegate.hudState = hudState
    }
  }
}
