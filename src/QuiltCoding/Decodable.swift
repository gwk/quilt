// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


extension Decodable {

  public init(jsonData: Data) throws {
    let decoder = JSONDecoder()
    self = try decoder.decode(Self.self, from: jsonData)
  }
}
