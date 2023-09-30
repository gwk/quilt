// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import UTest
@testable import Quilt


func testString() {


}


func testContains() {
  let s = "abc"
  let c:Character = "c"
  utest(exp: true, s.contains(c))
  utest(exp: true, s.contains(string: "bc", atIndex: s.index(after: s.startIndex)))
}


func testPart() {
  let (a, c) = "abc".part("b")!
  utest(exp: "a", a)
  utest(exp: "c", c)
}
