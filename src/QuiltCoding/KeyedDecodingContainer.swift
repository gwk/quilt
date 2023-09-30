// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


extension KeyedDecodingContainer {

  @inline(__always)
  public func decode<T>(key: KeyedDecodingContainer.Key) throws -> T where T: Decodable {
    try self.decode(T.self, forKey: key)
  }


  @inline(__always)
  public func decodeOpt<T>(key: KeyedDecodingContainer.Key) throws -> T? where T: Decodable {
    try self.decodeIfPresent(T.self, forKey: key)
  }
}
