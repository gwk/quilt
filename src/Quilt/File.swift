// Copyright © 2015 George King. Permission to use this file is granted in ploy/license.txt.

import Darwin


public class File: CustomStringConvertible, TextOutputStream {
  // the File public classs encapsulates a system file descriptor.

  public typealias Descriptor = Int32
  public typealias Stats = Darwin.stat
  public typealias Perms = mode_t


  public enum Err: Error {
    case changePerms(path: Path, perms: Perms)
    case copy(from: Path, to: Path)
    case open(path: Path, msg: String)
    case read(path: Path, offset: Int, len: Int)
    case readMalloc(path: Path, len: Int)
    case seek(path: Path, pos: Int)
    case stat(path: Path, msg: String)
    case decode(path: Path, encoding: String.Encoding)
  }


  public enum Mode {

    case append
    case eventNotification
    case read
    case update
    // case updateAppend? Does this work / make sense?
    case updateNoTruncate
    case write
    case writeNoTruncate

    var flags: I32 {
      switch self {
      case .append: return O_WRONLY | O_APPEND
      case .eventNotification: return O_EVTONLY
      case .read: return O_RDONLY
      case .update: return O_RDWR | O_TRUNC
      case .updateNoTruncate: return O_RDWR
      case .write: return O_WRONLY | O_TRUNC
      case .writeNoTruncate: return O_WRONLY
      }
    }

    public var isReadable: Bool {
      switch self {
      case .read, .update, .updateNoTruncate: return true
      default: return false
      }
    }

    public var isWritable: Bool {
      switch self {
      case .update, .updateNoTruncate, .write, .writeNoTruncate: return true
      default: return false
      }
    }

    public var isUpdatable: Bool {
      switch self {
      case .update, .updateNoTruncate: return true
      default: return false
      }
    }
  }


  public struct Options: OptionSet {

    public let rawValue: I32

    public init(rawValue: I32) { self.rawValue = rawValue }

    public static let exclusiveCreate = O_EXCL // error if O_CREAT and the file exists. TODO: move to Mode?
    public static let nonblocking = O_NONBLOCK
    public static let sharedLock = O_SHLOCK
    public static let exclusiveLock = O_EXLOCK
    public static let doNotFollowSymlinks = O_NOFOLLOW
    public static let openSymlinks = O_SYMLINK
    public static let closeOnExec = O_CLOEXEC
  }


  public let path: Path
  public let descriptor: Descriptor // note: misuse of the descriptor can cause leaks and other errors.
  public let mode: Mode
  public let options: Options
  public let shouldClose: Bool

  deinit {
    if shouldClose {
      if Darwin.close(descriptor) != 0 { errL("WARNING: File.close failed: \(self); \(stringForCurrentError())") }
    }
  }


  public init(path: Path, descriptor: Descriptor, mode: Mode, options: Options = [], shouldClose: Bool) {
    guard descriptor >= 0 else { fatalError("bad file descriptor for File named: \(path)") }
    self.path = path
    self.descriptor = descriptor
    self.mode = mode
    self.options = options
    self.shouldClose = shouldClose
  }


  public convenience init(path: Path, expandUserToOpen: Bool = true, mode: Mode = .read, options: Options = [], shouldClose: Bool = true,
   create: Perms? = nil) throws {
    self.init(
      path: path,
      descriptor: try File.openDescriptor(path: path, expandUserToOpen: expandUserToOpen, mode: mode, options: options, create: create),
      mode: mode,
      options: options,
      shouldClose: shouldClose)
  }


  public class func openDescriptor(path: Path, expandUserToOpen: Bool = true, mode: Mode = .read, options: Options = [], create: Perms? = nil) throws -> Descriptor {
    let expandedPath = (expandUserToOpen && path.isUserAbs) ? expandUser(path) : path
    let descriptor: Descriptor
    if let perms = create {
      descriptor = Darwin.open(expandedPath.string, mode.flags | options.rawValue | O_CREAT, perms)
    } else {
      descriptor = Darwin.open(expandedPath.string, mode.flags | options.rawValue)
    }
    guard descriptor >= 0 else { throw Err.open(path: path, msg: stringForCurrentError()) }
    return descriptor
  }


  public var isReadable: Bool { return mode.isReadable }

  public var isWritable: Bool { return mode.isWritable }

  public var isUpdatable: Bool { return mode.isUpdatable }


  public var description: String {
    return "\(type(of: self))(path:'\(path)', descriptor: \(descriptor))"
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

  public func len() throws -> Int { return try Int(stats().st_size) }


  public func read(len: Int, ptr: MutRawPtr) throws -> Int {
    assert(isReadable)
    let actualLen = Darwin.read(descriptor, ptr, len)
    guard actualLen >= 0 else { throw Err.read(path: path, offset: -1, len: len) }
    return actualLen
  }


  public func readAbs(offset: Int, len: Int, ptr: MutRawPtr) throws -> Int {
    assert(isReadable)
    let actualLen = Darwin.pread(descriptor, ptr, len, off_t(offset))
    guard actualLen >= 0 else { throw Err.read(path: path, offset: offset, len: len) }
    return actualLen
  }


  public func readBytes() throws -> [UInt8] {
    assert(isReadable)
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
    assert(isReadable)
    let bytes = try readBytes()
    guard let s = String(bytes: bytes, encoding: encoding) else {
      throw Err.decode(path: path, encoding: encoding)
    }
    return s
  }


  public func copy(to dstFile: File) throws {
    assert(isReadable)
    assert(dstFile.isWritable)
    let attrs: Int32 = COPYFILE_ACL|COPYFILE_STAT|COPYFILE_XATTR|COPYFILE_DATA
    guard Darwin.fcopyfile(self.descriptor, dstFile.descriptor, nil, copyfile_flags_t(attrs)) == 0 else {
      throw Err.copy(from: path, to: dstFile.path)
    }
  }


  public func changePerms(_ perms: Perms) throws {
    guard Darwin.fchmod(descriptor, perms) == 0 else { throw Err.changePerms(path: path, perms: perms) } // TODO: stringForCurrentError?
  }


  public func write(_ string: String, allowLossy: Bool) {
    File.writeBytes(descriptor: descriptor, string: string, allowLossy: allowLossy)
  }


  public func write(_ string: String) {
    write(string, allowLossy: false)
  }


  public func writeL(_ string: String) {
    write(string)
    write("\n")
  }


  public static func copy(from fromPath: Path, to toPath: Path, create: Perms? = nil) throws {
    try File(path: fromPath).copy(to: File(path: toPath, mode: .write, create: create))
  }


  public static func changePerms(path: Path, perms: Perms) throws {
    guard Darwin.chmod(path.string, perms) == 0 else { throw Err.changePerms(path: path, perms: perms) }
  }


  public static func readBytes(path: Path) throws -> [UInt8] {
    let f = try File(path: path)
    return try f.readBytes()
  }


  public static func writeBytes(descriptor: File.Descriptor, string: String, allowLossy: Bool) {
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
}
