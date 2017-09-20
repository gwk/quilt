// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

@testable import Quilt
import QTest

class Tests: TestCase {

  // functions beginning with 'test' are automatically run by `swift test`.
  func testA() {
    ufail()
  }
  func testB() {}
}

//public func ufail(_ msg: @autoclosure ()->String="", file: StaticString = #file, line: UInt = #line) {

