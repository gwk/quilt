// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


extension Array {

  public mutating func permuteInPlace(_ random: Random) {
    if isEmpty { return }
    let c = count
    for i in 1..<c {
      let j = c - i
      let k = random.int(j + 1)
      if j == k { continue }
      swap(&self[j], &self[k])
    }
  }

  public func permute(_ random: Random) -> Array {
    var a = self
    a.permuteInPlace(random)
    return a
  }

  public func randomElement(_ random: Random) -> Element {
    return self[random.int(count)]
  }
}
