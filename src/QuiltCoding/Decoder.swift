// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


extension Decoder {

  public func decode<T>() throws -> T where T: Decodable {
    let c = try singleValueContainer()
    return try c.decode(T.self)
  }
}
