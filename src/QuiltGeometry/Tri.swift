// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Quilt


public struct Tri: CustomStringConvertible {
  public var a, b, c: Int

  public init(_ a: Int, _ b: Int, _ c: Int) {
    assert(a < b && a < c)
    self.a = a
    self.b = b
    self.c = c
  }

  public static var invalid: Tri = Tri(-3, -2, -1)

  subscript(index: Int) -> Int {
      get {
        switch index {
        case 0: return a
        case 1: return b
        case 2: return c
        default: fatalError("Tri index out of range: \(index)")
        }
      }
      set(newValue) {
        switch index {
        case 0: a = newValue
        case 1: b = newValue
        case 2: c = newValue
        default: fatalError("Tri index out of range: \(index)")
        }
      }
  }

  public var description: String { return "Tri(\(a), \(b), \(c))" }

  public var swizzled: Tri { return Tri(a, c, b) }

  public func validate(vertexCount: Int) {
    precondition(a >= 0 && a < vertexCount)
    precondition(b >= 0 && b < vertexCount)
    precondition(c >= 0 && c < vertexCount)
    precondition(a < b)
    precondition(a < c)
  }

  private mutating func _rotateIndicesFwd() {
    let d = c
    c = b
    b = a
    a = d
  }

  private mutating func _rotateIndicesRev() {
    let d = a
    a = b
    b = c
    c = d
  }

  public mutating func fixIndexOrder() {
    if a > b {
      if b > c {
        _rotateIndicesFwd()
      } else {
        _rotateIndicesRev()
      }
    } else if a > c {
      _rotateIndicesFwd()
    }
    assert(a <= b)
    assert(a <= c)
  }

  public func commonEdge(_ t: Tri) -> Seg {
    for i in 0..<3 {
      let e0 = self[i]
      let e1 = self[(i+1) % 3]
      for j in 0..<3 {
        if e0 == t[(j+1) % 3] && e1 == t[j] {
          return Seg(e0, e1)
        }
      }
    }
    fatalError("no common edge between \(self) and \(t).")
  }

  public func commonEdgeTriangleIndices(_ t1: Tri) -> ((Int, Int), (Int, Int)) {
    for t0q in 0..<3 { // Iterate around t0 (self).
      let t0r = (t0q+1) % 3 // Next vertex index.
      let vq = self[t0q]
      let vr = self[t0r]
      for t1q in 0..<3 { // Iterate around t1.
        let t1r = (t1q+1) % 3
        if t1[t1r] == vq && t1[t1q] == vr {
          return ((t0q, t0r), (t1q, t1r))
        }
      }
    }
    fatalError("no common edge between \(self) and \(t1).")
  }
}
