// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import UTest
@testable import Quilt


func testPathNormalization() {
  utest(exp: "a", Path("a")!.string)
  utest(exp: "a/b", Path("a/b")!.string)
  utest(exp: "/a/b", Path("/a/b")!.string)
  utest(exp: "/a/b/", Path("/a/b/")!.string)

  utest(exp: ".", Path(".")!.string)
  utest(exp: ".", Path("./.")!.string)
  utest(exp: ".", Path("a/..")!.string)

  utest(exp: "a", Path("./a")!.string)

  utest(exp: "..", Path("../.")!.string)
  utest(exp: "..", Path("./..")!.string)
}
