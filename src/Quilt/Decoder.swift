// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension Decoder {

  func decode<T>() throws -> T where T: Decodable {
    let c = try singleValueContainer()
    return try c.decode(T.self)
  }
}

