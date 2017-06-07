// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension FileHandle: TextOutputStream {

  public func write(_ string: String) {
    // TODO: use string.getBytes() to write a min(pageSige, string.maximumLengthOfBytes()) at a time.
    string.utf8CString.withUnsafeBufferPointer {
      (buffer: UnsafeBufferPointer<CChar>) -> () in
        _ = Darwin.write(fileDescriptor, buffer.baseAddress, buffer.count - 1) // do not write null terminator.
    }
  }
}
