import XCTest


public typealias TestCase = XCTestCase


// TODO: #column, #function?

public func utest<T: Equatable>(exp: T, _ actClosure: @autoclosure () throws -> T,
 _ msg: @autoclosure ()->String = "", file: StaticString = #file, line: UInt = #line) {
  do {
    let act = try actClosure()
    if act != exp {
      ufail("\n  expected \(exp)\n  actual: \(act)")
    }
  } catch let e {
     ufail("\n  expected \(exp)\n  caught: \(e)")
     return
   }
}


public func utest<S1: Sequence, S2: Sequence>(seq: S1, _ actClosure: @autoclosure () throws -> S2,
 _ msg: @autoclosure ()->String = "", file: StaticString = #file, line: UInt = #line)
 where S1.Element == S2.Element, S1.Element: Comparable {
  let exp = Array(seq)
  do {
    let act = try Array(actClosure())
    if act != exp {
      ufail("\n  expected \(exp)\n  actual: \(act)")
    }
  } catch let e {
     ufail("\n  expected \(exp)\n  caught: \(e)")
     return
   }
}


public func ufail(_ msg: String = "", file: StaticString = #file, line: UInt = #line) {
  XCTFail(msg, file: file, line: line)
}

