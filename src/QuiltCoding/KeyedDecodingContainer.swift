// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

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
