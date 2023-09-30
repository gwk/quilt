// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public struct HalfEdge: Comparable, Hashable {
  public let va, vb: Int

  public static func <(l: HalfEdge, r: HalfEdge) -> Bool {
    if (l.va == r.va) {
      return l.vb < r.vb
    } else {
      return l.va < r.va
    }
  }
}
