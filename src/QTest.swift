import XCTest


public typealias TestCase = XCTestCase

public func ufail(_ msg: String = "", file: StaticString = #file, line: UInt = #line) {
  XCTFail(msg, file: file, line: line)
}

