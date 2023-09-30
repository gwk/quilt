// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import UTest
@testable import Quilt


func testOptionalComparable() {
  typealias OI = Int?

  utest(exp: false, OI(nil) < OI(nil))
  utest(exp: false, OI(0) < OI(nil))
  utest(exp: false, OI(0) < OI(0))
  utest(exp: true, OI(nil) < OI(0))
}
