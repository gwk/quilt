// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension FileHandle: TextOutputStream {

  public func write(_ string: String) { write(string, allowLossy: false) }

  public func write(_ string: String, allowLossy: Bool) {
    let bufferLength = Int(Darwin.getpagesize())
    let options = allowLossy ? String.EncodingConversionOptions.allowLossy : []
    var buffer: [UInt8] = [UInt8](repeating: 0, count: bufferLength)
    // note: The buffer must be initialized as getBytes will not resize it.
    // additionally, as of swift 3.1 if buffer is empty then we will end up writing garbage
    // this appears to be a bug in getBytes.
    var usedLength = 0
    var range: Range<String.Index> = string.startIndex..<string.endIndex
    while !range.isEmpty {
      _ = string.getBytes(&buffer, maxLength: 4096, usedLength: &usedLength,
        encoding: .utf8, options: options, range: range, remaining: &range)
      let bytesWritten = Darwin.write(fileDescriptor, buffer, usedLength)
      if bytesWritten == -1 {
        fail("write error: \(stringForCurrentError())")
      }
    }
  }
}
