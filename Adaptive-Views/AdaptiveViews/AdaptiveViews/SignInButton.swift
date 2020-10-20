//

import SwiftUI

extension Color {
  static let appleTint = Color.black
  static let googleTint = Color(red: 222 / 255.0, green: 82 / 255.0, blue: 70 / 255.0)
  static let twitterTint = Color(red: 29 / 255.0, green: 161 / 255.0, blue: 242 / 255.0)
}

struct SignInButton: View {

  enum Mode {
    case regular
    case compact
  }

  var action: () -> Void
  var tintColor: Color
  var imageName: String
  var mode: Mode

  var body: some View {
    Button(action: action) {
      switch mode {
      case .compact:
        Circle()
          .fill(tintColor)
          .overlay(Image(imageName))
          .frame(width: 44, height: 44)
      case .regular:
        HStack {
          Text("Sign in with")
          Image(imageName)
        }
        .padding()
        .background(
          Capsule()
            .fill(tintColor)
        )
      }
    }
    .foregroundColor(.white)
  }
}

struct SignInButton_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SignInButton(action: {}, tintColor: .appleTint, imageName: "apple", mode: .regular)
      SignInButton(action: {}, tintColor: .appleTint, imageName: "apple", mode: .compact)
      SignInButton(action: {}, tintColor: .googleTint, imageName: "google", mode: .regular)
      SignInButton(action: {}, tintColor: .googleTint, imageName: "google", mode: .compact)

      SignInButton(action: {}, tintColor: .twitterTint, imageName: "twitter", mode: .regular)
      SignInButton(action: {}, tintColor: .twitterTint, imageName: "twitter", mode: .compact)
    }
    .previewLayout(.sizeThatFits)
  }
}
