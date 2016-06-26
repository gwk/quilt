// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension NSOutputStream: OutputStream {
  
  public func write(_ string: String) {
    string.asUtf8() {
      (ptr, len) -> () in
      if len > 0 {
        let written = self.write(ptr, maxLength: len)
        // TODO: real error handling.
        assert(len == written, "\(len) != \(written); error: \(self.streamError)")
      }
      return ()
    }
  }

  public func writeLn(_ string: String) {
    write(string)
    write("\n")
  }

  public func writeLines(_ strings: String...) {
    for s in strings {
      writeLn(s)
    }
  }
}


public func streamTo(_ path: String, append: Bool = false) -> NSOutputStream? {
  if let url = path.fileUrl {
    if let s = NSOutputStream(url: url, append: append) {
      s.open()
      return s
    }
  }
  return nil
}

