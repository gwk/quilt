// © 2019 George King. Permission to use this file is granted in license-quilt.txt.


public struct HalfEdge: Comparable, Hashable {
  let va, vb: Int

  public static func <(l: HalfEdge, r: HalfEdge) -> Bool {
    if (l.va == r.va) {
      return l.vb < r.vb
    } else {
      return l.va < r.va
    }
  }
}
