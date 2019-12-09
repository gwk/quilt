// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Quilt


public struct Tri: CustomStringConvertible, Hashable {
  public var a, b, c: Int

  public init(_ a: Int, _ b: Int, _ c: Int) {
    assert(a < b && a < c)
    self.a = a
    self.b = b
    self.c = c
  }

  public init(unordered a: Int, _ b: Int, _ c: Int) {
    self.a = a
    self.b = b
    self.c = c
    self.rotateIndicesToCanonical()
  }

  public static var invalid: Tri = Tri(-3, -2, -1)

  subscript(index: Int) -> Int {
      get {
        switch index {
        case 0: return a
        case 1: return b
        case 2: return c
        default: fatalError("Tri subscript index out of range: \(index).")
        }
      }
      set {
        switch index {
        case 0: a = newValue
        case 1: b = newValue
        case 2: c = newValue
        default: fatalError("Tri subscript index out of range: \(index).")
        }
      }
  }

  public var description: String { return "Tri(\(a), \(b), \(c))" }

  public var swizzled: Tri { return Tri(a, c, b) }

  public var vertexIndices: [Int] { return [a, b, c] }


  public var halfEdges: [HalfEdge] {
    return [
      HalfEdge(va: a, vb: b),
      HalfEdge(va: b, vb: c),
      HalfEdge(va: c, vb: a),
    ]
  }


  public func validate(vertexCount: Int) {
    precondition(a >= 0 && a < vertexCount)
    precondition(b >= 0 && b < vertexCount)
    precondition(c >= 0 && c < vertexCount)
    precondition(a < b)
    precondition(a < c)
  }


  mutating func rotateIndicesFwd() {
    let d = c
    c = b
    b = a
    a = d
  }


  mutating func rotateIndicesRev() {
    let d = a
    a = b
    b = c
    c = d
  }


  public mutating func rotateIndicesToCanonical() {
    if a > b {
      if b > c {
        rotateIndicesFwd()
      } else {
        rotateIndicesRev()
      }
    } else if a > c {
      rotateIndicesFwd()
    }
    assert(a <= b)
    assert(a <= c)
  }


  mutating func rotateIndicesToMinVertex<V: Comparable>(vertices: [V]) {
    let va = vertices[a]
    let vb = vertices[b]
    let vc = vertices[c]
    if va > vb {
      if vb > vc {
        rotateIndicesFwd()
      } else {
        rotateIndicesRev()
      }
    } else if va > vc {
      rotateIndicesFwd()
    }
  }


  public func triVertexIndex(meshVertexIndex vi: Int) -> Int {
    if vi == a { return 0 }
    if vi == b { return 1 }
    if vi == c { return 2 }
    return -1
  }


  public func commonSegment(_ t: Tri) -> Seg {
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
