// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Darwin


public class Dir {

  private typealias Handle = MutPtr<Darwin.DIR>

  public enum Err: Error {
    case path(Path)
  }

  public let path: Path
  private let handle: Handle?

  public init(_ path: Path) throws {
    self.path = path
    self.handle = opendir(path.expandUser)
    if self.handle == nil {
      throw Err.path(path)
    }
  }

  public func listNames(prefix: String? = nil, suffix: String? = nil, includeHidden: Bool = false) -> [String] {
    var names = [String]()
    while true {
      let entryPtr = Darwin.readdir(handle)
      if entryPtr == nil {
        break
      }
      var nameBytes = entryPtr?.pointee.d_name // a 256-tuple of CChar.
      let name: String = withUnsafePointer(to: &nameBytes) {
        String(utf8String: UnsafeRawPointer($0).assumingMemoryBound(to: CChar.self))!
      }
      if !includeHidden {
        if name.hasPrefix(".") { continue }
      }
      else if [".", ".."].contains(name) { continue }
      if let prefix = prefix {
        if !name.hasPrefix(prefix) { continue }
      }
      if let suffix = suffix {
        if !name.hasSuffix(suffix) { continue }
      }
      names.append(name)
    }
    return names
  }
  public func listPaths(prefix: String? = nil, suffix: String? = nil) -> [Path] {
    return listNames(prefix: prefix, suffix: suffix).map() { Path("\(path.string)/\($0)") }
  }
}
