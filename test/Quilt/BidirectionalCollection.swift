// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import UTest
@testable import Quilt


func testBidirectionalCollection() {

  let s0 = "abc"
  utest(exp: "b", s0[s0.lastIndex(of: "b")!])
}
