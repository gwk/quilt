// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension Data {

  init(contentsOfFile path: String, options: Data.ReadingOptions = []) throws {
    self = try Data(contentsOf: URL(fileURLWithPath: path), options: options)
  }

  init(resPath: String, options: Data.ReadingOptions = []) {
    self = try! Data(contentsOfFile: pathForResource(resPath), options: options)
  }
  
  init(bufferPointer: UnsafeRawBufferPointer) {
    self = Data(bytes: bufferPointer.baseAddress!, count: bufferPointer.count)
  }
}
