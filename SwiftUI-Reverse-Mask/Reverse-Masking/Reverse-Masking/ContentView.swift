import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        Section("Reverse masking") {
          NavigationLink("Star Mask", destination: FSView1())
          NavigationLink("Text Mask", destination: FSView2())
          NavigationLink("Fading effect", destination: FSView3())
        }
        Section("Blending") {
          NavigationLink("Rectangle vs Circle", destination: FSView4())
          NavigationLink("Fade effect vs Circle", destination: FSView5())
        }
      }
      .navigationTitle("View Masking")
    }
  }
}
