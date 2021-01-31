// Gist from http://fivestars.blog/swiftui/custom-view-styles.html

import SwiftUI

// This gist shows you how to build your own style for your own SwiftUI views/
// components.
//
// Here's the list of steps:
// 1. Create view
// 2. Create view style protocol
// 3. Create style configuration
// 4. Implement base view styles
// 5. Define view default style
// 6. Setup style environment (key + environment value + style eraser)
// 7. Define `.xxxStyle(_:)` convenience view modifier
// 8. Update view to take advantage of environment style

// MARK: 1. Create view

//struct Card<Content: View>: View {
//  var content: () -> Content
//
//  var body: some View {
//    content()
//  }
//}

// MARK: 2. Create view style protocol

protocol CardStyle {
  associatedtype Body: View
  typealias Configuration = CardStyleConfiguration

  func makeBody(configuration: Self.Configuration) -> Self.Body
}

// MARK: 3. Create style configuration

struct CardStyleConfiguration {
  /// A type-erased content of a `Card`.
  struct Label: View {
    init<Content: View>(content: Content) {
      body = AnyView(content)
    }

    var body: AnyView
  }

  let label: CardStyleConfiguration.Label
}

// MARK: 4. Implement base view styles

struct RoundedRectangleCardStyle: CardStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.title)
      .padding()
      .background(RoundedRectangle(cornerRadius: 16).strokeBorder())
  }
}

struct CapsuleCardStyle: CardStyle {
  var color: Color

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.title)
      .foregroundColor(.white)
      .padding()
      .background(
        Capsule().fill(color)
      )
      .background(
        Capsule().fill(color.opacity(0.4)).rotationEffect(.init(degrees: -8))
      )
      .background(
        Capsule().fill(color.opacity(0.4)).rotationEffect(.init(degrees: 4))
      )
      .background(
        Capsule().fill(color.opacity(0.4)).rotationEffect(.init(degrees: 8))
      )
      .background(
        Capsule().fill(color.opacity(0.4)).rotationEffect(.init(degrees: -4))
      )
  }
}

struct ShadowCardStyle: CardStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.title)
      .foregroundColor(.black)
      .padding()
      .background(Color.white.cornerRadius(16))
      .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
  }
}

struct ColorfulCardStyle: CardStyle {
  var color: Color

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.title)
      .foregroundColor(.white)
      .shadow(color: Color.white.opacity(0.8), radius: 4, x: 0, y: 2)
      .padding()
      .background(
        color.cornerRadius(16)
      )
      .shadow(color: color, radius: 8, x: 0, y: 4)
  }
}

// MARK: 5. Define view default style

struct DefaultCardStyle: CardStyle {
  func makeBody(configuration: Configuration) -> some View {
    #if os(iOS)
      return ShadowCardStyle().makeBody(configuration: configuration)
    #else
      return RoundedRectangleCardStyle().makeBody(configuration: configuration)
    #endif
  }
}

// MARK: 6. Setup style environment (key + environment value + style eraser)

struct AnyCardStyle: CardStyle {
  private var _makeBody: (Configuration) -> AnyView

  init<S: CardStyle>(style: S) {
    _makeBody = { configuration in
      AnyView(style.makeBody(configuration: configuration))
    }
  }

  func makeBody(configuration: Configuration) -> some View {
    _makeBody(configuration)
  }
}

struct CardStyleKey: EnvironmentKey {
  static var defaultValue = AnyCardStyle(style: DefaultCardStyle())
}

extension EnvironmentValues {
  var cardStyle: AnyCardStyle {
    get { self[CardStyleKey.self] }
    set { self[CardStyleKey.self] = newValue }
  }
}

// MARK: 7. Define `.xxxStyle(_:)` convenience view modifier

extension View {
  func cardStyle<S: CardStyle>(_ style: S) -> some View {
    environment(\.cardStyle, AnyCardStyle(style: style))
  }
}

// MARK: 8. Update view to take advantage of environment style

struct Card<Content: View>: View {
  @Environment(\.cardStyle) var style
  var content: () -> Content

  var body: some View {
    style
      .makeBody(
        configuration: CardStyleConfiguration(
          label: CardStyleConfiguration.Label(content: content())
        )
      )
  }
}

// MARK: 9. Enjoy :)

struct ContentView: View {

  var body: some View {
    ScrollView {
      LazyVStack {
        // Default style
        Section {
          sectionContent
        }

        // RoundedRectangleCardStyle
        Section {
          sectionContent
        }
        .cardStyle(RoundedRectangleCardStyle())

        // CapsuleCardStyle - green
        Section {
          sectionContent
        }
        .cardStyle(CapsuleCardStyle(color: .green))

        // CapsuleCardStyle - blue
        Section {
          sectionContent
        }
        .cardStyle(CapsuleCardStyle(color: .blue))

        // ColorfulCardStyle - purple
        Section {
          sectionContent
        }
        .cardStyle(ColorfulCardStyle(color: .purple))

        // ColorfulCardStyle - pink
        Section {
          sectionContent
        }
        .cardStyle(ColorfulCardStyle(color: .pink))

        // ColorfulCardStyle - red
        Section {
          sectionContent
        }
        .cardStyle(ColorfulCardStyle(color: .red))
      }
    }
  }

  var sectionContent: some View {
    ScrollView(.horizontal) {
      LazyHStack {
        ForEach(1..<5) { _ in
          Card {
            Text(verbatim: "Five Stars")
          }
        }
      }
      .padding()
    }
  }
}

struct ContentView_Preview: PreviewProvider {
  static var previews: some View {
    ContentView()
      .padding()
      .previewLayout(.sizeThatFits)
  }
}