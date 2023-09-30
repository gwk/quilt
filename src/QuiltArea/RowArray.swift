// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import QuiltArithmetic
import Quilt
import QuiltVec


public class RowArray<Element>: AreaArray<Element> {

  // Row-major area array.

  public typealias Row = ArraySlice<Element>


  override public func index(_ coord: V2I) -> Int {
    size.x * coord.y + coord.x
  }

  override public func coord(_ index: Int) -> V2I {
    V2I(index % size.x, index / size.x)
  }


  override public func indicesByCol(start: V2I = .zero, end: V2I? = nil, step: V2I = .one) -> AreaIndexIterator { mustOverride() }


  override public func indicesByRow(start: V2I = .zero, end: V2I? = nil, step: V2I = .one) -> AreaIndexIterator {
    if let end = end {
      precondition(end.x >= 0 && end.x <= size.x && end.y >= 0 && end.y <= size.y,
                   "indicesByRow: `end` parameter is out-of-bounds: \(end); size: \(size)")
    }
    let end = end ?? size
    let startIndex = index(start)
    let endIndex = end.y * size.x
    let endRun = startIndex + end.x - start.x
    return AreaIndexIterator(start: startIndex, end: endIndex, endRun: endRun, stepMajor: size.x * step.y, stepMinor: step.x)
  }


  override public func mapToRows<R>(_ transform: (Element)->R) -> RowArray<R> {
    RowArray<R>(size: size, seq: array.map(transform))
  }

  override public func mapToCols<R>(_ transform: (Element)->R) -> ColArray<R> {
    fatalError("RowArray to ColArray not yet implemented.")
  }


  public func row(_ y: Int) -> Row {
    let off = size.x * y
    return self[off..<(off + size.x)]
  }


  public func indexQuadsByRow() -> LazyMapSequence<AreaIndexIterator, (ll: Int, hl: Int, lh: Int, hh: Int)> {
    // Note: the four indices are in coordinate lexicographic (column-major) order.
    let sizeX = size.x
    return indicesByRow(end: size &- 1).lazy.map {
      ll in
      return (
        ll: ll,
        hl: ll + 1,
        lh: ll + sizeX,
        hh: ll + sizeX + 1)
    }
  }
}
