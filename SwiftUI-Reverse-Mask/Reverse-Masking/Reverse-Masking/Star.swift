//

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

@propertyWrapper
public struct Clamping<Value: Comparable> {
  var value: Value
  let range: ClosedRange<Value>

  public init(wrappedValue: Value, _ range: ClosedRange<Value>) {
    precondition(range.contains(wrappedValue))
    self.range = range
    self.value = wrappedValue
  }

  public var wrappedValue: Value {
    get { value }
    set { value = min(max(range.lowerBound, newValue), range.upperBound) }
  }
}
