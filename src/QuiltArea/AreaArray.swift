// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import QuiltArithmetic
import Quilt
import QuiltVec


public class AreaArray<Element>: Collection {

  public typealias Iterator = Array<Element>.Iterator
  public typealias Index = Array<Element>.Index

  public private(set) var size: V2I = V2I()
  public var array: Array<Element> = []


  public init() {}


  public convenience init<S: Sequence>(size: V2I, seq: S) where S.Element == Element {
    self.init()
    precondition(size.x >= 0 && size.y >= 0, "AreaArray.init: negative size: \(size)")
    self.size = size
    self.array = Array(seq)
    if size.x * size.y != array.count { fatalError("AreaArray.init: size \(size) does not match count: \(array.count)") }
  }

  public convenience init(size: V2I, val: Element) {
    self.init()
    resize(size, val: val)
  }


  public func index(_ coord: V2I) -> Int { mustOverride() }

  public func coord(_ index: Int) -> V2I { mustOverride() }


  public func indicesByCol(start: V2I = .zero, end: V2I? = nil, step: V2I = .one) -> AreaIndexIterator { mustOverride() }

  public func indicesByRow(start: V2I = .zero, end: V2I? = nil, step: V2I = .one) -> AreaIndexIterator { mustOverride() }

  public func mapToRows<R>(_ transform: (Element)->R) -> RowArray<R> { mustOverride() }

  public func mapToCols<R>(_ transform: (Element)->R) -> ColArray<R> { mustOverride() }


  public var count: Int { array.count }

  public var quadsPerRow: Int { size.x - 1 }

  public var quadsPerCol: Int { size.y - 1 }

  public var quadCount: Int { quadsPerRow * quadsPerCol }


  public func makeIterator() -> Iterator { array.makeIterator() }

  public var startIndex: Index { array.startIndex }

  public var endIndex: Index { array.endIndex }

  public var lastCoord: V2I { size &- 1 }


  public subscript(i: Int) -> Element {
    get { array[i] }
    set { array[i] = newValue }
  }

  public subscript(range: Range<Index>) -> ArraySlice<Element> {
    get { array[range] }
    set { array[range] = newValue }
  }

  public func index(after i: Index) -> Index {
    array.index(after: i)
  }

  public func resize(_ size: V2I, val: Element) {
    precondition(size.x >= 0 && size.y >= 0, "AreaArray.resize: negative size: \(size)")
    self.size = size
    self.array = Array(repeating: val, count: size.x * size.y)
  }


  @inline(__always)
  public func el(_ coord: V2I) -> Element { array[index(coord)] }

  @inline(__always)
  public func setEl(_ coord: V2I, _ val: Element) { array[index(coord)] = val }

  @inline(__always)
  public func el(_ x: Int, _ y: Int) -> Element { el(V2I(x, y)) }

  @inline(__always)
  public func setEl(_ x: Int, _ y: Int, _ val: Element) { setEl(V2I(x, y), val) }


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


  public func withBuffer<R>(_ body: (Buffer<Element>) -> R) -> R {
    array.withBuffer(body)
  }

  public func withMutRawPtr<R>(_ body: (MutRawPtr) -> R) -> R {
    array.withUnsafeMutableBytes {
      body($0.baseAddress!)
    }
  }


  public func coordsByCol(start: V2I = .zero, end: V2I? = nil, step: V2I = .one) -> ColCoordIterator {
    if let end = end {
      precondition(end.x >= 0 && end.x <= size.x && end.y >= 0 && end.y <= size.y,
                   "coordsByCol: `end` parameter is out-of-bounds: \(end); size: \(size)")
    }
    let end = end ?? size
    return ColCoordIterator(start: start, end: end, step: step)
  }


  public func coordsByRow(start: V2I = .zero, end: V2I? = nil, step: V2I = .one) -> RowCoordIterator {
    if let end = end {
      precondition(end.x >= 0 && end.x <= size.x && end.y >= 0 && end.y <= size.y,
                   "coordsByRow: `end` parameter is out-of-bounds: \(end); size: \(size)")
    }
    let end = end ?? size
    return RowCoordIterator(start: start, end: end, step: step)
  }


  public func coordsByCol(inset: Int, step: V2I = .one) -> ColCoordIterator {
    coordsByCol(start: V2I(inset, inset), end: V2I(size.x - inset, size.y - inset))
  }


  public func coordsByRow(inset: Int, step: V2I = .one) -> RowCoordIterator {
    coordsByRow(start: V2I(inset, inset), end: V2I(size.x - inset, size.y - inset))
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

