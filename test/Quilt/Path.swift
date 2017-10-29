// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import UTest
@testable import Quilt


func testPath() {

  utest(exp: ".", Path("").string)
  utest(exp: ".", Path(".").string)
  utest(exp: "/", Path("/").string)
  utest(exp: "~", Path("~").string)
  utest(exp: "~/", Path("~/").string)
  utest(exp: "~NOBODY", Path("~NOBODY").string)
  utest(exp: "~NOBODY/", Path("~NOBODY/").string)

  utest(exp: "a", Path("a").string)
  utest(exp: "a/", Path("a/").string)
  utest(exp: "/a", Path("/a").string)
  utest(exp: "/a/", Path("/a/").string)
  utest(exp: "~/a", Path("~/a").string)

  utest(exp: "a/b", Path("a/b").string)
  utest(exp: "a/b/", Path("a/b/").string)
  utest(exp: "/a/b", Path("/a/b").string)
  utest(exp: "/a/b/", Path("/a/b/").string)

  let d = Path(".")
  utest(exp: d, Path("./."))
  utest(exp: d, Path("a/.."))

  let d_ = Path("./")
  utest(exp: "./", d_.string)
  utest(exp: d_, Path(".//"))
  utest(exp: d_, Path("a/../"))

  utest(exp: "a", Path("a/.").string)
  utest(exp: "./a", Path("./a").string)

  let r = Path("/")
  utest(exp: "/", r.string)
  utest(exp: r, Path("//"))
  utest(exp: r, Path("/."))
  utest(exp: r, Path("/a/.."))

  utest(exp: "../", Path("../").string)
  utest(exp: "../", Path("..").string)
  utest(exp: "../", Path("../.").string)
  utest(exp: "../", Path("./..").string)
  utest(exp: "/../", Path("/../").string)
  utest(exp: "/../", Path("/..").string)

  utest(exp: sysHomeDirStringNoSlash, Path("~/..").string)
  utest(exp: sysHomeDirStringNoSlash, Path("~nobody/..").string)

  utest(exp: "a/b", Path("a").cat(Path("b")))
  utest(exp: "a/b", Path("a/").cat(Path("b")))
  utest(exp: "a/b", Path("a").cat(Path("/b")))

  utest(exp: "a/", Path("a/b.ext").dir)
  utest(exp: "b.ext", Path("a/b.ext").name)
  utest(exp: "a/b", Path("a/b.ext").stem)

  utest(exp: "", Path("a").ext)
  utest(exp: "", Path("a.d/").ext)
  utest(exp: "", Path("a.d/b").ext)
  utest(exp: "", Path(".ext").ext)
  utest(exp: "", Path("a/.ext").ext)
  utest(exp: ".ext", Path("a.ext").ext)
  utest(exp: ".ext", Path("a/b.ext").ext)

  utest(exp: "a/b", Path("a/b").replaceExt(""))
  utest(exp: "a/b", Path("a/b.c").replaceExt(""))
  utest(exp: "a/b.d", Path("a/b.c").replaceExt(".d"))
  utest(exp: "a/b.d", Path("a/b").replaceExt(".d"))

  utest(seq: ["a", "b"], ["a", "b"])
  utest(seq: ["/", "a", "/"], Path("/a/").parts)

  utest(exp: "a/b", Path(parts: ["a", "b"]))
  utest(exp: "/a/b/", Path(parts: ["/", "a", "b", "/"]))

  utest(opt: nil, Path.commonParent("a", "b"))
  utest(opt: "a", Path.commonParent("a/b", "a/c"))
}
