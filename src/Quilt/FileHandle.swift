// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension FileHandle: TextOutputStream {

  public func write(_ string: String, allowLossy: Bool) {
    writeBytes(descriptor: fileDescriptor, string: string, allowLossy: allowLossy)
  }

  public func write(_ string: String) { write(string, allowLossy: false) }
}

// Annoyingly, TextOutputStream protocol requires that the FileHandle references be mutable.
public var stdOut = FileHandle.standardOutput
public var stdErr = FileHandle.standardError


public func outZ(_ head: Any, _ tail: Any...) { stdOut.write(head: head, tail: tail, sep: "", end: "") }
public func errZ(_ head: Any, _ tail: Any...) { stdErr.write(head: head, tail: tail, sep: "", end: "") }

public func outL(_ head: Any, _ tail: Any..., sep: String = "") { stdOut.write(head: head, tail: tail, sep: sep, end: "\n") }
public func errL(_ head: Any, _ tail: Any..., sep: String = "") { stdErr.write(head: head, tail: tail, sep: sep, end: "\n") }

public func outSL(_ head: Any, _ tail: Any...) { stdOut.write(head: head, tail: tail, sep: " ", end: "\n") }
public func errSL(_ head: Any, _ tail: Any...) { stdErr.write(head: head, tail: tail, sep: " ", end: "\n") }

public func outLL(_ head: Any, _ tail: Any...) { stdOut.write(head: head, tail: tail, sep: "\n", end: "\n") }
public func errLL(_ head: Any, _ tail: Any...) { stdErr.write(head: head, tail: tail, sep: "\n", end: "\n") }

public func warn(_ items: Any..., sep: String = " ") {
  stdErr.write(head: "WARNING: ", tail: items, sep: sep, end: "\n")
}
