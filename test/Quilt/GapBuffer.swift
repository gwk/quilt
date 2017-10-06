// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import UTest
@testable import Quilt


func testGapBufferBasics() {
  var b = GapBuffer<String>()
  b.append(contentsOf: ["0", "1", "2"])
  utest(seq: ["0", "1", "2"], b)
}
