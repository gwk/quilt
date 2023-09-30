// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import UTest
@testable import Quilt


func testGapBufferBasics() {
  var b = GapBuffer<String>()
  b.append(contentsOf: ["0", "1", "2"])
  utest(seq: ["0", "1", "2"], b)
}
