import SwiftUI

struct Star: Shape {
  @Clamping(0...Int.max) var points: Int = 5
  var innerRatio = 0.4

  func path(in rect : CGRect) -> Path {
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let angle: Double = .pi / Double(points)
    var path = Path()
    var startPoint: CGPoint = rect.origin

    let outerRadius = min(rect.width / 2, rect.height / 2)
    let innerRadius = outerRadius * innerRatio

    let maxCorners = 2 * points
    for corner in 0 ..< maxCorners {
      let radius = (corner % 2) == 0 ? outerRadius : innerRadius

      let x = center.x + cos(Double(corner) * angle) * radius
      let y = center.y + sin(Double(corner) * angle) * radius
      let point = CGPoint(x: x, y: y)

      if corner == 0 {
        startPoint = point
        path.move(to: point)
      } else {
        path.addLine(to: point)
      }
      if corner == (maxCorners - 1) {
        path.addLine(to: startPoint)
      }
    }
    return path
  }
}

struct DoubleEllipse: Shape {
  /// 1 = complete overlap
  /// 0 = no overlap
  @Clamping(0.0...1.0) var overlapping: Double = 0

  func path(in rect: CGRect) -> Path {
    let rectSize = CGSize(width: (rect.width / 2) * (1 + overlapping), height: rect.height)

    var path = Path()
    path.addEllipse(in: CGRect(origin: .zero, size: rectSize))
    let secondEllipseOrigin = CGPoint(x: (rect.width / 2) * (1 - overlapping), y: rect.origin.y)
    path.addEllipse(in: CGRect(origin: secondEllipseOrigin, size: rectSize))

    return path
  }
}

struct OverlappingEllipses: Shape {
  @Clamping(1...Int.max) var ellipsesNumber: Int = 2
  @Clamping(0.0...1.0) var overlapping: Double = 0

  var animatableData: CGFloat {
    get { overlapping }
    set { overlapping = newValue }
  }

  func path(in rect: CGRect) -> Path {
    let rectWidth = (rect.width / Double(ellipsesNumber)) * (1 + Double(ellipsesNumber - 1) * overlapping)
    let rectSize = CGSize(width: rectWidth, height: rect.height)

    var path = Path()
    for index in 0..<ellipsesNumber {
      let ellipseOrigin = CGPoint(x: (rect.width - rectWidth) * Double(index) / Double(ellipsesNumber - 1), y: rect.origin.y)
      path.addEllipse(in: CGRect(origin: ellipseOrigin, size: rectSize))
    }

    return path
  }
}

struct OverlappingRectangles: Shape {
  @Clamping(1...Int.max) var rectanglesNumber: Int = 2
  @Clamping(0.0...1.0) var overlapping: Double = 0

  var animatableData: CGFloat {
    get { overlapping }
    set { overlapping = newValue }
  }

  func path(in rect: CGRect) -> Path {
    let rectWidth = (rect.width / Double(rectanglesNumber)) * (1 + Double(rectanglesNumber - 1) * overlapping)
    let rectSize = CGSize(width: rectWidth, height: rect.height)

    var path = Path()
    for index in 0..<rectanglesNumber {
      let ellipseOrigin = CGPoint(x: (rect.width - rectWidth) * Double(index) / Double(rectanglesNumber - 1), y: rect.origin.y)
      path.addRect(CGRect(origin: ellipseOrigin, size: rectSize))
    }

    return path
  }
}
