// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import UTest
@testable import Quilt


func testFileManager() {

  utest(exp: true, currentDir().hasDirSuffix)
  utest(exp: true, userTempDir().hasDirSuffix)

  utest(exp: "/", absPath("/"))
  utest(exp: "~", absPath("~"))
  utest(exp: "~/", absPath("~/"))
  utest(exp: "~/", absPath(userHomeDirString))

  utest(exp: "~/zzz", absPath(userHomeDirString + "zzz")) // should collapse current user.

  utest(exp: "~NOBODY", absPath(sysHomeDirString + "NOBODY")) // should collapse other user.
}
