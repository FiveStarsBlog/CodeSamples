//

import SwiftUI

struct ExperimentalView: View {
  @State var currentWidth: CGFloat = 0
  @State var padding: CGFloat = 8
  @State var threshold: CGFloat = 100

  var body: some View {
    VStack {
      AdaptiveView(threshold: threshold) {
        RoundedRectangle(cornerRadius: 40.0, style: .continuous)
          .fill(
            Color(red: 224 / 255.0, green: 21 / 255.0, blue: 90 / 255.0, opacity: 1)
          )
        RoundedRectangle(cornerRadius: 40.0, style: .continuous)
          .fill(
        Color.pink
          )
      }
      .readSize { size in
        currentWidth = size.width
      }
      .overlay(
        Rectangle()
          .stroke(lineWidth: 2)
          .frame(width: threshold)
      )
      .padding(.horizontal, padding)

      Text("Current width: \(Int(currentWidth))")
      HStack {
        Text("Threshold: \(Int(threshold))")
        Slider(value: $threshold, in: 0...500, step: 1) { Text("") }
      }
      HStack {
        Text("Padding:")
        Slider(value: $padding, in: 0...500, step: 1) { Text("") }
      }
    }
    .padding()
  }
}
