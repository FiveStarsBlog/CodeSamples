import SwiftUI

struct HudSceneView: View {
  @EnvironmentObject var hudState: HudState

  var body: some View {
    Color.clear
      .ignoresSafeArea(.all)
      .hud(isPresented: $hudState.isPresented) {
        Label(hudState.title, systemImage: hudState.systemImage)
      }
  }
}

