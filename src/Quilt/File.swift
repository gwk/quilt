// Copyright © 2015 George King. Permission to use this file is granted in ploy/license.txt.

import Darwin


public class File: CustomStringConvertible {
  // the File public classs encapsulates a system file descriptor.
  // the design is intended to:
  // prevent misuse of the file descriptor that could lead to problems like file descriptor leaks.
  // for example, calling close on a raw file descriptor could allow that descriptor to be reassigned to a new file;
  // aliases of that descriptor will then misuse the new file.

  public typealias Descriptor = Int32
  public typealias Stats = Darwin.stat
  public typealias Perms = mode_t

  enum Err: Error {
    case changePerms(path: String, perms: Perms)
    case copy(from: String, to: String)
    case open(path: String, msg: String)
    case read(path: String, offset: Int, len: Int)
    case readMalloc(path: String, len: Int)
    case seek(path: String, pos: Int)
    case stat(path: String, msg: String)
    case utf8Decode(path: String)
  }

  public let path: String
  fileprivate let descriptor: Descriptor

  deinit {
    if Darwin.close(descriptor) != 0 { errL("WARNING: File.close failed: \(self); \(stringForCurrentError())") }
  }

  public init(path: String, descriptor: Descriptor) {
    guard descriptor >= 0 else { fatalError("bad file descriptor for File at path: \(path)") }
    self.path = path
    self.descriptor = descriptor
  }

  public class func openDescriptor(_ path: String, mode: CInt, create: Perms? = nil) throws -> Descriptor {
    var descriptor: Descriptor
    if let perms = create {
      descriptor = Darwin.open(path, mode | O_CREAT, perms)
    } else {
      descriptor = Darwin.open(path, mode)
    }
    guard descriptor >= 0 else { throw Err.open(path: path, msg: stringForCurrentError()) }
    return descriptor
  }

  public convenience init(path: String, mode: CInt, create: Perms? = nil) throws {
    self.init(path: path, descriptor: try File.openDescriptor(path, mode: mode, create: create))
  }

  public var description: String {
    return "\(type(of: self))(path:'\(path)', descriptor: \(descriptor))"
  }

  internal var _dispatchSourceHandle: Descriptor {
    // note: this is a purposeful leak of the private descriptor so that File+Dispatch can be defined as an extension.
    return descriptor
  }

  public func stats() throws -> Stats {
    var stats = Darwin.stat()
    let res = Darwin.fstat(descriptor, &stats)
    guard res == 0 else { throw Err.stat(path: path, msg: stringForCurrentError()) }
    return stats
  }

  public func seekAbs(_ pos: Int) throws {
    guard Darwin.lseek(descriptor, off_t(pos), SEEK_SET) == 0 else { throw Err.seek(path: path, pos: pos) }
  }

  public func rewind() throws {
    try seekAbs(0)
  }

  public func rewindMaybe() -> Bool {
    do {
      try rewind()
    } catch {
      return false
    }
    return true
  }

  public static func changePerms(_ path: String, _ perms: Perms) throws {
    guard Darwin.chmod(path, perms) == 0 else { throw Err.changePerms(path: path, perms: perms) }
  }

  public func copy(fromPath: String, toPath: String, create: Perms? = nil) throws {
    try InFile(path: fromPath).copyTo(OutFile(path: toPath, create: create))
  }
}


public class InFile: File {

  public convenience init(path: String, create: Perms? = nil) throws {
    self.init(path: path, descriptor: try File.openDescriptor(path, mode: O_RDONLY, create: create))
  }

  public func len() throws -> Int { return try Int(stats().st_size) }

  public func readAbs(offset: Int, len: Int, ptr: UnsafeMutableRawPointer) throws -> Int {
    let len_act = Darwin.pread(Int32(descriptor), ptr, len, off_t(offset))
    guard len_act >= 0 else { throw Err.read(path: path, offset: offset, len: len) }
    return len_act
  }

  public func readText() throws -> String {
    let len = try self.len()
    let bufferLen = len + 1
    let buffer = malloc(bufferLen)
    guard buffer != nil else { throw Err.readMalloc(path: path, len: len) }
    let len_act = try readAbs(offset: 0, len: len, ptr: buffer!)
    guard len_act == len else { throw Err.read(path: path, offset: 0, len: len) }
    let charBuffer = unsafeBitCast(buffer, to: UnsafeMutablePointer<CChar>.self)
    charBuffer[len] = 0 // null terminator.
    let s = String(validatingUTF8: charBuffer)
    free(buffer)
    guard let res = s else { throw Err.utf8Decode(path: path) }
    return res
  }

  public func copyTo(_ outFile: OutFile) throws {
    let attrs: Int32 = COPYFILE_ACL|COPYFILE_STAT|COPYFILE_XATTR|COPYFILE_DATA
    guard Darwin.fcopyfile(self.descriptor, outFile.descriptor, nil, copyfile_flags_t(attrs)) == 0 else {
      throw Err.copy(from: path, to: outFile.path)
    }
  }
}


public class OutFile: File, TextOutputStream {

  public convenience init(path: String, create: Perms? = nil) throws {
    self.init(path: path, descriptor: try File.openDescriptor(path, mode: O_WRONLY | O_TRUNC, create: create))
  }

  public func write(_ string: String) {
    _ = string.utf8CString.withUnsafeBufferPointer {
      (buffer: UnsafeBufferPointer<CChar>) -> () in
        _ = Darwin.write(descriptor, buffer.baseAddress, buffer.count - 1) // do not write null terminator.
    }
  }

  public func writeL(_ string: String) {
    write(string)
    write("\n")
  }

  public func setPerms(_ perms: Perms) {
    if Darwin.fchmod(descriptor, perms) != 0 {
      fail("setPerms(\(perms)) failed: \(stringForCurrentError()); '\(path)'")
    }
  }
}


public var std_in = InFile(path: "std_in", descriptor: STDIN_FILENO)
public var std_out = OutFile(path: "std_out", descriptor: STDOUT_FILENO)
public var std_err = OutFile(path: "std_err", descriptor: STDERR_FILENO)


public func out<T>(_ item: T)  { print(item, separator: "", terminator: "", to: &std_out) }
public func outL<T>(_ item: T) { print(item, separator: "", terminator: "\n", to: &std_out) }

public func err<T>(_ item: T)  { print(item, separator: "", terminator: "", to: &std_err) }
public func errL<T>(_ item: T) { print(item, separator: "", terminator: "\n", to: &std_err) }

public func errSL(_ items: Any...) {
  std_err.write(items, sep: " ", end: "\n")
}

public func warn(_ items: Any...) {
  err("WARNING: ")
  std_err.write(items, sep: " ", end: "\n")
}
