import SwiftUI

struct ContentView: View {
  let edge: Double = 600
  let blendModes: [BlendMode] = [
    .colorDodge, .lighten, .screen, .plusLighter, // Lighten
    .colorBurn, .darken, .multiply, .plusDarker, // Darken
    .overlay, .softLight, .hardLight, // Contrast
    .hue, .saturation, .color, .luminosity, // Component
    .sourceAtop, .destinationOver, .destinationOut, // Compositing
    .difference, .exclusion, // Invert
    .normal // Normal
  ]

  var body: some View {
    List {
      ForEach(blendModes, id: \.self) { blendMode in
        Section("\(blendMode)") {
          Matrix(blendMode: blendMode)
            .frame(width: edge, height: edge)
            .padding()
        }
      }
    }
  }
}

struct BlendingView<SourceView: View, DestinationView: View>: View {
  let blendMode: BlendMode
  let sourceView: SourceView
  let destinationView: DestinationView

  var body: some View {
    ZStack {
      destinationView
      sourceView
        .blendMode(blendMode)
    }
  }
}

struct Rainbow: View {
  let hueColors = stride(from: 0, to: 1, by: 0.01).map {
    Color(hue: $0, saturation: 1, brightness: 1)
  }

  var body: some View {
    LinearGradient(
      gradient: Gradient(colors: self.hueColors),
      startPoint: .leading,
      endPoint: .trailing
    )
  }
}

struct BlackToWhite: View {
  var body: some View {
    LinearGradient(
      gradient: Gradient(colors: [.black, .white]),
      startPoint: .top,
      endPoint: .bottom
    )
  }
}

struct BlackToTransparent: View {
  var body: some View {
    LinearGradient(
      gradient: Gradient(colors: [.black, .black.opacity(0)]),
      startPoint: .top,
      endPoint: .bottom
    )
  }
}

struct WhiteToTransparent: View {
  var body: some View {
    LinearGradient(
      gradient: Gradient(colors: [.white, .white.opacity(0)]),
      startPoint: .top,
      endPoint: .bottom
    )
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewLayout(.fixed(width: 300, height: 1000))
  }
}

struct Matrix: View {
  let blendMode: BlendMode

  var body: some View {
    VStack {
      HStack {
        Color.clear
          .overlay(alignment: .trailing) {
            Text("Destination →")
          }
          .overlay(alignment: .bottom) {
            Text("Source\n↓")
              .multilineTextAlignment(.center)
          }
        Rainbow()
        BlackToWhite()
      }
      MatrixRow(blendMode: blendMode, mainView: Rainbow())
      MatrixRow(blendMode: blendMode, mainView: BlackToWhite())
//      MatrixRow(blendMode: blendMode, mainView: BlackToTransparent())
//      MatrixRow(blendMode: blendMode, mainView: WhiteToTransparent())
    }
  }
}

struct MatrixRow<MainView: View>: View {
  let blendMode: BlendMode
  let mainView: MainView

  var body: some View {
    HStack {
      mainView
      BlendingView(blendMode: blendMode, sourceView: mainView, destinationView: Rainbow())
      BlendingView(blendMode: blendMode, sourceView: mainView, destinationView: BlackToWhite())
//      BlendingView(blendMode: blendMode, sourceView: mainView, destinationView: BlackToTransparent())
//      BlendingView(blendMode: blendMode, sourceView: mainView, destinationView: WhiteToTransparent())
    }
  }
}
