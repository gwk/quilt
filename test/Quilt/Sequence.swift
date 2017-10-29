// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import UTest
@testable import Quilt


func testSequence() {

  //utest(seq: ["a" : ["a", "aa"], "b" : ["b", "bb"]],
  //  ["", "a", "aa", "b", "bb"].group({$0.first}))

  // This mess is all due to SE 0143-conditional-conformances remaining unimplemented in swift 4.0.

  let group_act = ["", "a", "aa", "b", "bb"].group({$0.first})
  let group_exp: [Character:[String]] = ["a" : ["a", "aa"], "b" : ["b", "bb"]]
  utest(seq: group_act.keys, group_exp.keys)
  group_exp.forEach {
    utest(exp: true, group_act[$0.key]! == $0.value)
  }
}
