import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        Section("Introduction") {
          NavigationLink("no clip", destination: FSView0())
        }
        Section("Clipping") {
          NavigationLink("clipped()", destination: FSView1())
          NavigationLink("cornerRadius(:)", destination: FSView2())
          NavigationLink("clipShape(Circle())", destination: FSView3())
          NavigationLink("clipShape(Star())", destination: FSView4())
          NavigationLink("clipShape + even-odd rule", destination: FSView7())
          NavigationLink("clipShape + animation", destination: FSView8())
        }
        Section("Shapes") {
          NavigationLink("DoubleEllipse", destination: FSView5())
          NavigationLink("DoubleEllipse even-odd rule", destination: FSView6())
        }
      }
      .navigationTitle("View Clipping")
    }
  }
}
