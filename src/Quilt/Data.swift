// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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

  public func withUnsafeBuffer<T, R>(body: (UnsafeBufferPointer<T>) -> R) -> R {
    withUnsafeBytes {
      (buffer: UnsafeRawBufferPointer) in
      body(buffer.bindMemory(to: T.self))
    }
  }
}
