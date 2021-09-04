import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        Section("Masking") {
          NavigationLink("Alignment", destination: FSView1())
          NavigationLink("Views as masks", destination: FSView2())
          NavigationLink("Content bleeding", destination: FSView3())
          NavigationLink("Opacity gradient", destination: FSView4())
          NavigationLink("List + no mask", destination: FSView5())
          NavigationLink("List + fade", destination: FSView6())
          NavigationLink("List + blur", destination: FSView7())
        }
      }
      .navigationTitle("View Masking")
    }
  }
}
