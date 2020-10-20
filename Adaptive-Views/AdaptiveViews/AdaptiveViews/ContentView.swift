//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink("Image/Text", destination: AdaptiveExampleView())
        NavigationLink("Social Sign In", destination: SocialSignInView())
        NavigationLink("Experiment", destination: ExperimentalView())
      }
      .navigationBarTitle("Adaptive View Examples", displayMode: .inline)
    }
  }
}
