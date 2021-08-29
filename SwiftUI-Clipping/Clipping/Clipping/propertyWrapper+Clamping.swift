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
