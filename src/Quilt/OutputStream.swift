// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


extension OutputStream: TextOutputStream {

  public func write(_ string: String) {
    let bufferLength = min(string.utf16.count * 2, sysPageSize)
      // guess a reasonable buffer size to avoid allocating a full page for tiny strings.
    var buffer = [UInt8](repeating: 0, count: bufferLength)
    var range = string.startIndex..<string.endIndex
    while !range.isEmpty {
      var length = 0
      let ok = string.getBytes(&buffer, maxLength: bufferLength, usedLength: &length, encoding: .utf8,
        range: range, remaining: &range)
      if !ok {
        warn("OutputStream.write: string conversion failed.")
        break
      }
      self.write(&buffer, maxLength: length)
    }
  }
}
