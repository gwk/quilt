// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


public class AreaBuffer<Element>: Collection {

  public typealias Iterator = Array<Element>.Iterator
  public typealias Index = Array<Element>.Index
  public typealias Row = ArraySlice<Element>

  public private(set) var size: V2I = V2I()
  public private(set) var array: Array<Element> = []

  public init() {}

  public convenience init<S: Sequence>(size: V2I, seq: S) where S.Iterator.Element == Element {
    self.init()
    self.size = size
    self.array = Array(seq)
    if size.x * size.y != array.count { fatalError("AreaBuffer size \(size) does not match count: \(array.count)") }
  }

  public convenience init(size: V2I, val: Element) {
    self.init()
    resize(size, val: val)
  }

  public var count: Int { return array.count }

  public func makeIterator() -> Iterator { return array.makeIterator() }

  public var startIndex: Index { return array.startIndex }

  public var endIndex: Index { return array.endIndex }

  public subscript (i: Int) -> Element {
    get { return array[i] }
    set { array[i] = newValue }
  }

  public subscript (range: Range<Index>) -> ArraySlice<Element> {
    get { return array[range] }
    set { array[range] = newValue }
  }

  public func index(after i: Index) -> Index {
    return array.index(after: i)
  }
  
  public func withUnsafeBufferPointer<R>(_ body: @noescape (UnsafeBufferPointer<Element>) -> R) -> R {
    return array.withUnsafeBufferPointer(body)
  }

  public func allCoords(start: V2I, end: V2I, step: V2I = V2I(1, 1)) -> AreaIterator {
    return AreaIterator(start: start, end: end, step: step)
  }

  public func allCoords(end: V2I, step: V2I = V2I(1, 1)) -> AreaIterator {
    return allCoords(start: V2I(), end: end, step: step)
  }

  public func allCoords(step: V2I = V2I(1, 1)) -> AreaIterator {
    return allCoords(start: V2I(), end: size, step: step)
  }

  public func allCoords(inset: Int) -> AreaIterator {
    return allCoords(start: V2I(inset, inset), end: V2I(size.x - inset, size.y - inset))
  }

  public func resize(_ size: V2I, val: Element) {
    self.size = size
    array.removeAll(keepingCapacity: true)
    for _ in 0..<(size.x * size.y) {
      array.append(val)
    }
  }
  
  public func index(_ coord: V2I) -> Int {
    return size.x * coord.y + coord.x
  }

  public func coord(_ index: Int) -> V2I {
    return V2I(index % size.x, index / size.x)
  }

  public func isInBounds(_ coord: V2I) -> Bool {
    return coord.x >= 0 && coord.x < size.x && coord.y >= 0 && coord.y < size.y
  }

  public func isOnEdge(_ coord: V2I) -> Bool {
    return coord.x == 0 || coord.x == size.x - 1 || coord.y == 0 || coord.y == size.y - 1
  }

  public func isOnHighEdge(_ coord: V2I) -> Bool {
    return coord.x == size.x - 1 || coord.y == size.y - 1
  }

  public func isOnEdge(_ index: Int) -> Bool {
    return isOnEdge(coord(index))
  }

  public func isOnHighEdge(_ index: Int) -> Bool {
    return isOnHighEdge(coord(index))
  }

  public func row(_ y: Int) -> Row {
    let off = size.x * y
    return self[off..<(off + size.x)]
  }

  public func el(_ x: Int, _ y: Int) -> Element {
    return self[size.x * y + x]
  }

  public func el(_ coord: V2I) -> Element { return el(coord.x, coord.y) }
  
  public func setEl(_ i: Int, _ j: Int, _ val: Element) {
    self[size.x * j + i] = val
  }
  
  public func setEl(_ coord: V2I, _ val: Element) { setEl(coord.x, coord.y, val) }

  public func map<R>(_ transform: (Element)->R) -> AreaBuffer<R> {
    return AreaBuffer<R>(size: size, seq: array.map(transform))
  }
}


extension AreaBuffer where Element: ArithmeticProtocol {

  public func addEl(_ coord: V2I, _ delta: Element) -> Element {
    var val = el(coord)
    val = val + delta
    setEl(coord, val)
    return val
  }
}

