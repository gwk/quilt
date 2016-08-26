// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension OutputStream: TextOutputStream {

  public func write(_ string: String) {
    string.asUtf8NTUns() {
      (buffer) -> () in
      if buffer.count > 0 {
        let written = self.write(buffer.baseAddress!, maxLength: buffer.count - 1)
        // TODO: real error handling.
        assert(buffer.count == written, "\(buffer.count) != \(written); error: \(self.streamError)")
      }
      return ()
    }
  }
}
