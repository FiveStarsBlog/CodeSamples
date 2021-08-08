import SwiftUI

final class FSSceneDelegate: UIResponder, UIWindowSceneDelegate, ObservableObject {
  lazy var hudState = HudState()
  var keyWindow: UIWindow?
  var hudWindow: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    if let windowScene = scene as? UIWindowScene {
      setupMainWindow(in: windowScene)
      setupToastWindow(in: windowScene)
    }
  }

  func setupMainWindow(in scene: UIWindowScene) {
    let window = UIWindow(windowScene: scene)
    window.rootViewController = UIHostingController(rootView: MainSceneView().environmentObject(hudState))
    self.keyWindow = window
    window.makeKeyAndVisible()
  }

  func setupToastWindow(in scene: UIWindowScene) {
    let toastViewController = UIHostingController(rootView: HudSceneView().environmentObject(hudState))
    toastViewController.view.backgroundColor = .clear

    let hudWindow = PassThroughWindow(windowScene: scene)
    hudWindow.rootViewController = toastViewController
    hudWindow.isHidden = false
    self.hudWindow = hudWindow
  }
}
