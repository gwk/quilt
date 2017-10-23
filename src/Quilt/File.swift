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

  public enum Err: Error {
    case changePerms(path: String, perms: Perms)
    case copy(from: String, to: String)
    case open(path: String, msg: String)
    case read(name: String, offset: Int, len: Int)
    case readMalloc(name: String, len: Int)
    case seek(name: String, pos: Int)
    case stat(name: String, msg: String)
    case decode(name: String, encoding: String.Encoding)
  }

  public let name: String
  fileprivate let descriptor: Descriptor

  deinit {
    if Darwin.close(descriptor) != 0 { errL("WARNING: File.close failed: \(self); \(stringForCurrentError())") }
  }

  public init(name: String, descriptor: Descriptor) {
    guard descriptor >= 0 else { fatalError("bad file descriptor for File named: \(name)") }
    self.name = name
    self.descriptor = descriptor
  }

  public class func openDescriptor(path: String, mode: CInt, create: Perms? = nil) throws -> Descriptor {
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
    self.init(name: path, descriptor: try File.openDescriptor(path: path, mode: mode, create: create))
  }

  public var description: String {
    return "\(type(of: self))(name:'\(name)', descriptor: \(descriptor))"
  }

  internal var _dispatchSourceHandle: Descriptor {
    // note: this is a purposeful leak of the private descriptor so that File+Dispatch can be defined as an extension.
    return descriptor
  }

  public func stats() throws -> Stats {
    var stats = Darwin.stat()
    let res = Darwin.fstat(descriptor, &stats)
    guard res == 0 else { throw Err.stat(name: name, msg: stringForCurrentError()) }
    return stats
  }

  public func seekAbs(_ pos: Int) throws {
    guard Darwin.lseek(descriptor, off_t(pos), SEEK_SET) == 0 else { throw Err.seek(name: name, pos: pos) }
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

  public static func changePerms(path: String, _ perms: Perms) throws {
    guard Darwin.chmod(path, perms) == 0 else { throw Err.changePerms(path: path, perms: perms) }
  }

  public func copy(fromPath: String, toPath: String, create: Perms? = nil) throws {
    try InFile(path: fromPath).copyTo(OutFile(path: toPath, create: create))
  }
}


public class InFile: File {

  public convenience init(path: String, create: Perms? = nil) throws {
    self.init(name: path, descriptor: try File.openDescriptor(path: path, mode: O_RDONLY, create: create))
  }

  public func len() throws -> Int { return try Int(stats().st_size) }

  public func read(len: Int, ptr: MutRawPtr) throws -> Int {
    let actualLen = Darwin.read(descriptor, ptr, len)
    guard actualLen >= 0 else { throw Err.read(name: name, offset: -1, len: len) }
    return actualLen
  }

  public func readAbs(offset: Int, len: Int, ptr: MutRawPtr) throws -> Int {
    let actualLen = Darwin.pread(descriptor, ptr, len, off_t(offset))
    guard actualLen >= 0 else { throw Err.read(name: name, offset: offset, len: len) }
    return actualLen
  }

  public func readBytes() throws -> [UInt8] {
    var buffer: [UInt8] = [UInt8](repeating: 0, count: sysPageSize)
    var result = [UInt8]()
    while true {
      let actualLen = try read(len: sysPageSize, ptr: &buffer)
      result.append(contentsOf: buffer.prefix(actualLen))
      if actualLen != sysPageSize { break }
    }
    return result
  }

  public func readText(encoding: String.Encoding = .utf8) throws -> String {
    let bytes = try readBytes()
    guard let s = String(bytes: bytes, encoding: encoding) else {
      throw Err.decode(name: name, encoding: encoding)
    }
    return s
  }

  public func copyTo(_ outFile: OutFile) throws {
    let attrs: Int32 = COPYFILE_ACL|COPYFILE_STAT|COPYFILE_XATTR|COPYFILE_DATA
    guard Darwin.fcopyfile(self.descriptor, outFile.descriptor, nil, copyfile_flags_t(attrs)) == 0 else {
      throw Err.copy(from: name, to: outFile.name)
    }
  }
}


public class OutFile: File, TextOutputStream {

  public convenience init(path: String, create: Perms? = nil) throws {
    self.init(name: path, descriptor: try File.openDescriptor(path: path, mode: O_WRONLY | O_TRUNC, create: create))
  }

  public func write(_ string: String, allowLossy: Bool) {
    writeBytes(descriptor: descriptor, string: string, allowLossy: allowLossy)
  }

  public func write(_ string: String) {
    write(string, allowLossy: false)
  }

  public func writeL(_ string: String) {
    write(string)
    write("\n")
  }

  public func setPerms(_ perms: Perms) {
    if Darwin.fchmod(descriptor, perms) != 0 {
      fail("setPerms(\(perms)) failed: \(stringForCurrentError()); '\(name)'")
    }
  }
}


func readBytes(path: String) throws -> [UInt8] {
  let f = try InFile(path: path)
  return try f.readBytes()
}


func writeBytes(descriptor: File.Descriptor, string: String, allowLossy: Bool) {
  let options = allowLossy ? String.EncodingConversionOptions.allowLossy : []
  var buffer: [UInt8] = [UInt8](repeating: 0, count: sysPageSize)
  // Note: the buffer must be initialized as getBytes will not resize it.
  // Additionally, as of swift 3.1 if buffer is empty then we will end up writing garbage;
  // this appears to be a safety bug in getBytes.
  var usedLength = 0
  var range: Range<String.Index> = string.startIndex..<string.endIndex
  while !range.isEmpty {
    _ = string.getBytes(&buffer, maxLength: 4096, usedLength: &usedLength,
      encoding: .utf8, options: options, range: range, remaining: &range)
    let bytesWritten = Darwin.write(descriptor, buffer, usedLength)
    if bytesWritten != usedLength {
      fail("write error: \(stringForCurrentError())")
    }
  }
}
