import SwiftUI

final class FSSceneDelegate: UIResponder, UIWindowSceneDelegate, ObservableObject {
  var hudState: HudState? {
    didSet {
      setupHudWindow()
    }
  }
  var toastWindow: UIWindow?
  weak var windowScene: UIWindowScene?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    windowScene = scene as? UIWindowScene
  }

  func setupHudWindow() {
    guard let windowScene = windowScene, let toastState = hudState else {
      return
    }

    let toastViewController = UIHostingController(rootView: HudSceneView().environmentObject(toastState))
    toastViewController.view.backgroundColor = .clear

    let toastWindow = PassThroughWindow(windowScene: windowScene)
    toastWindow.rootViewController = toastViewController
    toastWindow.isHidden = false
    self.toastWindow = toastWindow
  }
}
