// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


public struct Edge: CustomStringConvertible, Comparable, Hashable {
  public var va, vb: Int
  public var tl, tr: Int

  public init(va: Int, vb: Int, tl: Int, tr: Int) {
    assert(va != vb)
    self.va = va
    self.vb = vb
    self.tl = tl
    self.tr = tr
  }

  public static var invalid: Edge { return Edge(va: -2, vb: -1, tl: -2, tr: -1) }

  public var description: String { return "Edge(va:\(va), vb:\(vb), tl:\(tl), tr:\(tr))" }


  public var halfEdges: [HalfEdge] {
    let he = HalfEdge(va: va, vb: vb)
    if tr < 0 { return [he] }
    return [he, HalfEdge(va: vb, vb: va)]
  }


  public func validate(vertexCount: Int, triangleCount: Int) {
    precondition(va >= 0 && va < vertexCount)
    precondition(vb >= 0 && vb < vertexCount)
    precondition(tl >= 0 && tl < triangleCount)
    precondition(tr < triangleCount) // `tr` is allowed to be negative, indicating no right-hand triangle.
  }


  public static func <(l: Edge, r: Edge) -> Bool {
    if (l.va == r.va) {
      return l.vb < r.vb
    } else {
      return l.va < r.va
    }
  }
}
