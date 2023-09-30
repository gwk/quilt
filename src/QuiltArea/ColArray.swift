// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import QuiltArithmetic
import Quilt
import QuiltVec


public class ColArray<Element>: AreaArray<Element> {

  // Column-major area array.

  public typealias Col = ArraySlice<Element>


  override public func index(_ coord: V2I) -> Int {
    size.y * coord.x + coord.y
  }

  override public func coord(_ index: Int) -> V2I {
    V2I(index / size.y, index % size.y)
  }


  override public func indicesByCol(start: V2I = .zero, end: V2I? = nil, step: V2I = .one) -> AreaIndexIterator {
    if let end = end {
      precondition(end.x >= 0 && end.x <= size.x && end.y >= 0 && end.y <= size.y,
                   "indicesByCol: `end` parameter is out-of-bounds: \(end); size: \(size)")
    }
    let end = end ?? size
    let startIndex = index(start)
    let endIndex = end.x * size.y
    let endRun = startIndex + end.y - start.y
    return AreaIndexIterator(start: startIndex, end: endIndex, endRun: endRun, stepMajor: size.y * step.x, stepMinor: step.y)
  }


  override public func indicesByRow(start: V2I = .zero, end: V2I? = nil, step: V2I = .one) -> AreaIndexIterator { mustOverride() }


  override public func mapToCols<R>(_ transform: (Element)->R) -> ColArray<R> {
    ColArray<R>(size: size, seq: array.map(transform))
  }

  override public func mapToRows<R>(_ transform: (Element)->R) -> RowArray<R> {
    fatalError("ColArray to RowArray not yet implemented.")
  }


  public func col(_ x: Int) -> Col {
    let off = size.y * x
    return self[off..<(off + size.y)]
  }


  public func indexQuadsByCol() -> LazyMapSequence<AreaIndexIterator, (ll: Int, lh: Int, hl: Int, hh: Int)> {
    // Note: the four indices are in coordinate lexicographic (column-major) order.
    let sizeY = size.y
    return indicesByCol(end: size &- 1).lazy.map {
      ll in
      return (
        ll: ll,
        lh: ll + 1,
        hl: ll + sizeY,
        hh: ll + sizeY + 1)
    }
  }
}
