// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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
