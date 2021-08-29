import SwiftUI

struct FSView0: View {
  var body: some View {
    Text("Five stars")
      .background(Color.yellow)
      .font(.system(size: 90))
      .fixedSize()
      .border(Color.blue)
      .frame(width: 200, height: 100)
      .border(Color.red)
  }
}

struct FSView1: View {
  var body: some View {
    Text("Five stars")
      .background(Color.yellow)
      .font(.system(size: 90))
      .fixedSize()
      .border(Color.blue)
      .frame(width: 200, height: 100)
      .border(Color.red)
      .clipped()
  }
}

struct FSView2: View {
  @State var cornerRadius: Double = 16

  var body: some View {
    VStack {
      Text("Five stars")
        .background(Color.yellow)
        .font(.system(size: 90))
        .fixedSize()
        .frame(width: 200, height: 100)
        .cornerRadius(cornerRadius)
      HStack {
        Text("Corner radius")
        Slider(value: $cornerRadius, in: 0...50)
      }
    }
    .padding()
  }
}

struct FSView3: View {
  var body: some View {
      Text("Five stars")
        .background(Color.yellow)
        .font(.system(size: 90))
        .fixedSize()
        .frame(width: 200, height: 100)
        .clipShape(Circle())
  }
}

struct FSView4: View {
  @State var points: Int = 5
  @State var angle: Double = 53

  var body: some View {
    VStack {
      Text("Five stars")
        .background(Color.yellow)
        .font(.system(size: 90))
        .fixedSize()
        .frame(width: 200, height: 100)
        .clipShape(Star(points: points).rotation(.degrees(angle)))
      Stepper("Star points", value: $points, in: 2...16)
      HStack {
        Text("Rotation Angle")
        Slider(value: $angle, in: 0.0...360.0)
      }
    }
    .padding()
  }
}

struct FSView5: View {
  @State var overlapping: Double = 0.1

  var body: some View {
    VStack {
      DoubleEllipse(overlapping: overlapping)
        .frame(width: 300, height: 100)
      HStack {
        Text("Overlapping")
        Slider(value: $overlapping, in: 0.0...1.0)
      }
    }
    .padding()
  }
}

struct FSView6: View {
  @State var overlapping: Double = 0.1

  var body: some View {
    VStack {
      DoubleEllipse(overlapping: overlapping)
        .fill(style: FillStyle(eoFill: true, antialiased: true))
        .frame(width: 300, height: 100)
      HStack {
        Text("Overlapping")
        Slider(value: $overlapping, in: 0.0...1.0)
      }
    }
    .padding()
  }
}

struct FSView7: View {
  @State var ellipsesNumber: Int = 8
  @State var overlapping: Double = 0

  var body: some View {
    VStack {
        Text("Five stars")
          .background(Color.yellow)
          .font(.system(size: 80))
          .clipShape(
            OverlappingEllipses(ellipsesNumber: ellipsesNumber, overlapping: overlapping),
            style: FillStyle(eoFill: true, antialiased: false)
          )
      Stepper("Ellipses number:", value: $ellipsesNumber, in: 2...16)
      HStack {
        Text("Overlapping")
        Slider(value: $overlapping, in: 0.0...1.0)
      }
    }
    .padding()
  }
}

struct FSView8: View {
  @State var shapeNumber: Int = 8
  @State var overlapping: Double = 0

  var body: some View {
    VStack(spacing: 16) {
        Text("Five stars")
          .background(Color.yellow)
          .font(.system(size: 80))
          .clipShape(
            OverlappingEllipses(
              ellipsesNumber: shapeNumber, overlapping: overlapping),
            style: FillStyle(eoFill: true, antialiased: false)
          )

      Text("Five stars")
        .background(Color.yellow)
        .font(.system(size: 80))
        .clipShape(
          OverlappingRectangles(rectanglesNumber: shapeNumber, overlapping: overlapping),
          style: FillStyle(eoFill: true, antialiased: false)
        )

      Button("Show/Hide") {
        withAnimation(.easeInOut(duration: 2)) {
          overlapping = overlapping == 1 ? 0 : 1
        }
      }
    }
    .padding()
  }
}
