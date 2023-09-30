// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import UTest
@testable import Quilt


func testSequence() {

  utest(exp: ["a" : ["a", "aa"], "b" : ["b", "bb"]],
    (["", "a", "aa", "b", "bb"] as [String]).group({$0.first}))

}
