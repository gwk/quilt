// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public func bitRevPermutation(_ powerOfTwo: Int) -> [Int] {
  var p = [0]
  for _ in 0..<powerOfTwo {
    let p2 = p.map { $0 * 2 }
    p = p2 + p2.map { $0 + 1 }
  }
  return p
}
