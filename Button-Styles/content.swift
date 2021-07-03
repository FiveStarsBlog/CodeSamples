import SwiftUI

/// Usage:
/// Button(...) { 
///   ...
/// }
/// .buttonStyle(.fiveStars)

extension ButtonStyle where Self == FiveStarsButtonStyle {
  static func fiveStars(cornerRadius: Double = 8) -> Self {
    FiveStarsButtonStyle(cornerRadius: cornerRadius)
  }

  static var fiveStars: FiveStarsButtonStyle {
    fiveStars()
  }
}

struct FiveStarsButtonStyle: ButtonStyle {
  @Environment(\.controlSize) var controlSize: ControlSize
  @Environment(\.controlProminence) var controlProminence: Prominence
  @Environment(\.isEnabled) var isEnabled: Bool
  @ScaledMetric var cornerRadius: Double

  func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .frame(maxWidth: controlSize == .large ? .infinity : nil)
      .padding(.horizontal, horizontalPadding)
      .padding(.vertical, verticalPadding)
      .foregroundColor(foregroundColor(for: configuration.role))
      .background {
        backgroundColor(for: configuration.role).cornerRadius(cornerRadius)
        if let borderColor = borderColor(for: configuration.role) {
          RoundedRectangle(cornerRadius: cornerRadius)
            .strokeBorder(borderColor, lineWidth: 2)
        }
      }
      .opacity(configuration.isPressed ? 0.5 : 1)
  }

  var horizontalPadding: Double {
    switch controlSize {
      case .mini:
        return 8
      case .small:
        return 16
      case .regular:
        return 32
      case .large:
        return 0 // no need.
      @unknown default:
        return 0
    }
  }

  var verticalPadding: Double {
    switch controlSize {
      case .mini:
        return 2
      case .small:
        return 4
      case .regular:
        return 8
      case .large:
        return 16
      @unknown default:
        return 0
    }
  }

  func foregroundColor(for role: ButtonRole?) -> Color? {
    guard isEnabled else { return Color(uiColor: .secondaryLabel) }

    switch (controlProminence, role) {
      case (.standard, .destructive?):
        return .red
      case (.increased, .destructive?):
        return .white
      case (.increased, _):
        return .black
      case (_, _):
        return nil
    }
  }

  func backgroundColor(for role: ButtonRole?) -> Color? {
    switch controlProminence {
      case .standard:
        break
      case .increased:
        return color(for: role)
      @unknown default:
        break
    }
    return nil
  }

  func color(for role: ButtonRole?) -> Color {
    guard isEnabled else { return Color(uiColor: .secondarySystemFill) }

    switch role {
      case .cancel?, .destructive?:
        return Color.red
      default:
        return Color.accentColor
    }
  }

  func borderColor(for role: ButtonRole?) -> Color? {
    switch controlProminence {
      case .standard:
        return color(for: role)
      case .increased:
        fallthrough
      @unknown default:
        return nil
    }
  }
}

// MARK: - Previews

struct Previews: PreviewProvider {
    static var previews: some View {
      HStack(spacing: 0) {
        previewContent
          .accentColor(Color(hue: 80 / 360.0, saturation: 0.98, brightness: 1))

        previewContent

        previewContent
          .accentColor(Color(hue: 80 / 360.0, saturation: 0.98, brightness: 1))
          .colorScheme(.dark)

        previewContent
          .colorScheme(.dark)
      }
      .buttonStyle(.fiveStars)
      .navigationViewStyle(.stack)
      .previewLayout(.fixed(width: 1280, height: 2600))
    }

  static var previewContent: some View {
    NavigationView {
      List {
        Section(header: Text("Default role")) {
          buttons()
        }

        Section(header: Text("Cancel Role")) {
          buttons(role: .cancel)
        }

        Section(header: Text("Destructive Role")) {
          buttons(role: .destructive)
        }

        Section(header: Text("Increased Prominence")) {
          buttons()
            .controlProminence(.increased)
        }

        Section(header: Text("Cancel Role + Increased prominence")) {
          buttons(role: .cancel)
            .controlProminence(.increased)
        }

        Section(header: Text("Cancel Role + Increased prominence")) {
          buttons(role: .destructive)
            .controlProminence(.increased)
        }

        Section(header: Text("Disabled")) {
          buttons()
            .disabled(true)
        }

        Section(header: Text("Disabled + Increased prominence")) {
          buttons(role: .destructive)
            .disabled(true)
            .controlProminence(.increased)
        }

        Section(header: Text("Accessibility5")) {
          buttons()
            .environment(\.dynamicTypeSize, .accessibility5)
        }
      }
      .listStyle(GroupedListStyle())
      .navigationBarTitle(Text("Buttons"))
    }
  }

  @ViewBuilder
  static func buttons(role: ButtonRole? = nil) -> some View {
    Button("Mini", role: role, action: action)
      .controlSize(.mini)
    Button("Small", role: role, action: action)
      .controlSize(.small)
    Button("Regular", role: role, action: action)
      .controlSize(.regular)
    Button("Large", role: role, action: action)
      .controlSize(.large)
  }

  static func action() -> Void {
  }
}
