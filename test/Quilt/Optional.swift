// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

import UTest
@testable import Quilt


func testOptionalComparable() {
  typealias OI = Int?

  utest(exp: false, OI(nil) < OI(nil))
  utest(exp: false, OI(0) < OI(nil))
  utest(exp: false, OI(0) < OI(0))
  utest(exp: true, OI(nil) < OI(0))
}
