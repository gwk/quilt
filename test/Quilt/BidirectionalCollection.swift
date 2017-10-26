// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import UTest
@testable import Quilt


func testBidirectionalCollection() {

  let s0 = "abc"
  utest(exp: "b", s0[s0.index(ofLast: "b")!])
}
