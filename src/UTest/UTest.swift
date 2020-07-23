// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public func utest<T: Equatable>(exp: T, _ actClosure: @autoclosure () throws -> T,
 _ msg: @autoclosure ()->String = "test failure.", file: StaticString = #file, line: UInt = #line, col: UInt = #column) {
  do {
    let act = try actClosure()
    if act != exp {
      ufail("\(msg())\n  expected: \(exp)\n    actual: \(act)", file: file, line: line, col: col)
    }
  } catch let e {
     ufail("\(msg())\n  expected: \(exp)\n  caught: \(e)", file: file, line: line, col: col)
     return
   }
}


public func utest<T: Equatable>(opt exp: T?, _ actClosure: @autoclosure () throws -> T?,
 _ msg: @autoclosure ()->String = "test failure.", file: StaticString = #file, line: UInt = #line, col: UInt = #column) {
  do {
    let act = try actClosure()
    if act != exp {
      ufail("\(msg())\n  expected: \(exp==nil ? "nil" : String(reflecting: exp!))\n    actual: \(act==nil ? "nil" : String(reflecting: act!))",
        file: file, line: line, col: col)
    }
  } catch let e {
     ufail("\(msg())\n  expected: \(exp==nil ? "nil" : String(reflecting: exp!))\n  caught: \(e)", file: file, line: line, col: col)
     return
   }
}


public func utest<S1: Sequence, S2: Sequence>(seq: S1, _ actClosure: @autoclosure () throws -> S2,
 _ msg: @autoclosure ()->String = "sequence test failure.", file: StaticString = #file, line: UInt = #line, col: UInt = #column)
 where S1.Element == S2.Element, S1.Element: Comparable {
  let exp = Array(seq)
  do {
    let act = try Array(actClosure())
    if act != exp {
      ufail("\(msg())\n  expected: \(exp)\n    actual: \(act)", file: file, line: line, col: col)
    }
  } catch let e {
     ufail("\(msg())\n  expected: \(exp)\n  caught: \(e)", file: file, line: line, col: col)
     return
   }
}


public func ufail(_ msg: String = "failure.", file: StaticString = #file, line: UInt = #line, col: UInt = #column) {
  let currentDir = Array(FileManager.default.currentDirectoryPath) + "/"
  let absPath = String(describing: file)
  let absChars = Array(absPath)
  let path = absChars.starts(with: currentDir) ? String(absChars[currentDir.count...]) : absPath
  let msg = "\(path):\(line):\(col): \(msg)\n"
  FileHandle.standardError.write(Data(msg.utf8))
}
