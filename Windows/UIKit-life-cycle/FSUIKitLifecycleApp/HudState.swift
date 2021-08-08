import Combine

final class HudState: ObservableObject {
  @Published var isPresented: Bool = false
  private(set) var title: String = ""
  private(set) var systemImage: String = ""

  func show(title: String, systemImage: String) {
    self.title = title
    self.systemImage = systemImage
    isPresented = true
  }
}
