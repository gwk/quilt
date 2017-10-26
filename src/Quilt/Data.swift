// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension Data {

  public init(path: Path, options: Data.ReadingOptions = []) throws {
    self = try Data(contentsOf: path.url, options: options)
  }

  public init(resPath: Path, options: Data.ReadingOptions = []) {
    self = try! Data(contentsOf: pathForResource(resPath).url, options: options)
  }

  public init(buffer: RawBuffer) {
    self = Data(bytes: buffer.baseAddress!, count: buffer.count)
  }
}
