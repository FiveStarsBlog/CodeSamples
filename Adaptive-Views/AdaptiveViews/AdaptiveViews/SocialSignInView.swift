//

import SwiftUI

struct SocialSignInView: View {
  @State private var availableWidth: CGFloat = 0

  private var buttonMode: SignInButton.Mode {
    availableWidth > 500 ? .regular : .compact
  }

  var body: some View {
    ZStack {
      Color.clear
        .frame(height: 1)
        .readSize { size in
          availableWidth = size.width
        }

      HStack {
        SignInButton(action: {}, tintColor: .appleTint, imageName: "apple", mode: buttonMode)
        SignInButton(action: {}, tintColor: .googleTint, imageName: "google", mode: buttonMode)
        SignInButton(action: {}, tintColor: .twitterTint, imageName: "twitter", mode: buttonMode)
      }
    }
  }
}

struct SocialSignInView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SocialSignInView()
        .previewLayout(.fixed(width: 568, height: 320))
      SocialSignInView()
        .previewLayout(.fixed(width: 320, height: 528))
    }
  }
}
