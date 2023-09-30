// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Darwin


extension Array {

  public mutating func permuteInPlace<G: RandomNumberGenerator>(rng: inout G) {
    if isEmpty { return }
    let c = count
    for i in 1..<c {
      let j = c - i
      let k = Int.random(in: 0...j, using: &rng)
      if j == k { continue }
      // note: as of swift 4b1, `swap(&self[j], &self[k])` warns about exclusive access.
      let v = self[j]
      self[j] = self[k]
      self[k] = v
    }
  }

  public func permute<G: RandomNumberGenerator>(rng: inout G) -> Array {
    var a = self
    a.permuteInPlace(rng: &rng)
    return a
  }

  public func randomEl<G: RandomNumberGenerator>(rng: inout G) -> Element {
    self[Int.random(in: 0..<count, using: &rng)]
  }
}
