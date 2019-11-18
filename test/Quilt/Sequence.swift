// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import UTest
@testable import Quilt


func testSequence() {

  utest(exp: ["a" : ["a", "aa"], "b" : ["b", "bb"]],
    (["", "a", "aa", "b", "bb"] as [String]).group({$0.first}))

}
