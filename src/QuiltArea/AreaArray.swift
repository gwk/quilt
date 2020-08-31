// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import QuiltArithmetic
import Quilt
import QuiltVec


public class AreaArray<Element>: Collection {

  public typealias Iterator = Array<Element>.Iterator
  public typealias Index = Array<Element>.Index
  public typealias Row = ArraySlice<Element>

  public private(set) var size: V2I = V2I()
  public private(set) var array: Array<Element> = []

  public init() {}

  public convenience init<S: Sequence>(size: V2I, seq: S) where S.Element == Element {
    self.init()
    self.size = size
    self.array = Array(seq)
    if size.x * size.y != array.count { fatalError("AreaArray size \(size) does not match count: \(array.count)") }
  }

  public convenience init(size: V2I, val: Element) {
    self.init()
    resize(size, val: val)
  }

  public var count: Int { array.count }

  public func makeIterator() -> Iterator { array.makeIterator() }

  public var startIndex: Index { array.startIndex }

  public var endIndex: Index { array.endIndex }

  public subscript (i: Int) -> Element {
    get { array[i] }
    set { array[i] = newValue }
  }

  public subscript (range: Range<Index>) -> ArraySlice<Element> {
    get { array[range] }
    set { array[range] = newValue }
  }

  public func index(after i: Index) -> Index {
    array.index(after: i)
  }

  public func allCoords(start: V2I, end: V2I, step: V2I = V2I(1, 1)) -> AreaIterator {
    AreaIterator(start: start, end: end, step: step)
  }

  public func allCoords(end: V2I, step: V2I = V2I(1, 1)) -> AreaIterator {
    allCoords(start: V2I(), end: end, step: step)
  }

  public func allCoords(step: V2I = V2I(1, 1)) -> AreaIterator {
    allCoords(start: V2I(), end: size, step: step)
  }

  public func allCoords(inset: Int) -> AreaIterator {
    allCoords(start: V2I(inset, inset), end: V2I(size.x - inset, size.y - inset))
  }

  public func resize(_ size: V2I, val: Element) {
    self.size = size
    self.array = Array(repeating: val, count: size.x * size.y)
  }

  public func index(_ coord: V2I) -> Int {
    size.x * coord.y + coord.x
  }

  public func coord(_ index: Int) -> V2I {
    V2I(index % size.x, index / size.x)
  }

  public func isInBounds(_ coord: V2I) -> Bool {
    coord.x >= 0 && coord.x < size.x && coord.y >= 0 && coord.y < size.y
  }

  public func isOnEdge(_ coord: V2I) -> Bool {
    coord.x == 0 || coord.x == size.x - 1 || coord.y == 0 || coord.y == size.y - 1
  }

  public func isOnHighEdge(_ coord: V2I) -> Bool {
    coord.x == size.x - 1 || coord.y == size.y - 1
  }

  public func isOnEdge(_ index: Int) -> Bool {
    isOnEdge(coord(index))
  }

  public func isOnHighEdge(_ index: Int) -> Bool {
    isOnHighEdge(coord(index))
  }

  public func row(_ y: Int) -> Row {
    let off = size.x * y
    return self[off..<(off + size.x)]
  }

  public func el(_ x: Int, _ y: Int) -> Element {
    self[size.x * y + x]
  }

  public func el(_ coord: V2I) -> Element { el(coord.x, coord.y) }

  public func setEl(_ i: Int, _ j: Int, _ val: Element) {
    self[size.x * j + i] = val
  }

  public func setEl(_ coord: V2I, _ val: Element) { setEl(coord.x, coord.y, val) }

  public func mapToArea<R>(_ transform: (Element)->R) -> AreaArray<R> {
    AreaArray<R>(size: size, seq: array.map(transform))
  }


  public func withBuffer<R>(_ body: (Buffer<Element>) -> R) -> R {
    array.withBuffer(body)
  }


  public func withMutRawPtr<R>(_ body: (MutRawPtr) -> R) -> R {
    array.withUnsafeMutableBytes {
      body($0.baseAddress!)
    }
  }
}


extension AreaArray where Element: ArithmeticProtocol {

  public func addEl(_ coord: V2I, _ delta: Element) -> Element {
    var val = el(coord)
    val = val + delta
    setEl(coord, val)
    return val
  }
}

