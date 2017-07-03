// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension Data {

  init(contentsOfFile path: String, options: Data.ReadingOptions = []) throws {
    self = try Data(contentsOf: URL(fileURLWithPath: path), options: options)
  }
}
