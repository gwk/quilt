// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension UnkeyedDecodingContainer {

  mutating func decodeRemaining<T>() throws -> [T] where T: Decodable {
    var els: [T] = []
    while !isAtEnd {
      els.append(try decode(T.self))
    }
    return els
  }
}
