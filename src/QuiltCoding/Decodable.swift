// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension Decodable {

  public init(jsonData: Data) throws {
    let decoder = JSONDecoder()
    self = try decoder.decode(Self.self, from: jsonData)
  }
}
