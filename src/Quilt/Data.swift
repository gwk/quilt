// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension Data {

  public init(contentsOfFile path: String, options: Data.ReadingOptions = []) throws {
    self = try Data(contentsOf: URL(fileURLWithPath: path), options: options)
  }

  public init(resPath: String, options: Data.ReadingOptions = []) {
    self = try! Data(contentsOfFile: pathForResource(resPath), options: options)
  }

  public init(buffer: RawBuffer) {
    self = Data(bytes: buffer.baseAddress!, count: buffer.count)
  }
}
