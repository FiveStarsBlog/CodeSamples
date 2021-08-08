import SwiftUI

@main
struct FSSwiftUILifecycleApp: App {
  @StateObject var hudState = HudState()
  @UIApplicationDelegateAdaptor var delegate: FSAppDelegate
  
  var body: some Scene {
    WindowGroup {
      MainSceneView()
        .environmentObject(hudState)
    }
  }
}
