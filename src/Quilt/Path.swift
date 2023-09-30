// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


public struct Path: Equatable, ExpressibleByStringLiteral, CustomStringConvertible {

  public typealias StringLiteralType = String

  public let string: String

  public init(_ string: String) {
    self.string = Path.normalize(string: string)
  }

  public init?(_ string: String?) {
    guard let string = string else { return nil }
    self.init(string)
  }

  public init(_ substring: Substring) {
    self.string = Path.normalize(string: String(substring))
  }

  public init?(_ substring: Substring?) {
    guard let substring = substring else { return nil }
    self.init(substring)
  }

  public init(_ url: URL) {
    precondition(url.isFileURL)
    self = Path(url.path)
  }

  public init?( _ url: URL?) {
    guard let url = url else { return nil }
    self.init(url)
  }

  public init(stringLiteral: StringLiteralType) {
    self = Path(stringLiteral)
  }

  public init(parts: [String]) {
    self.string = Path.normalize(string: parts.joined(char: sysPathSepChar))
  }

  public var description: String { string }

  public var url: URL { URL(fileURLWithPath: expandUser) }

  public var isRootAbs: Bool { string.first == sysPathSepChar }

  public var isUserAbs: Bool { string.first == sysHomePrefixChar }

  public var isAbs: Bool { isRootAbs || isUserAbs }

  public var isRel: Bool { !isAbs }

  public var hasDirSuffix: Bool { string.last == sysPathSepChar }

  public var apparentDir: Path { hasDirSuffix ? self : cat("..") }

  public var stem: Path {
    // The "stem" is the portion of the path up to the '.ext' extension.
    guard let i = extDotIndex else { return self }
    return Path(string[..<i])
  }

  public var dir: Path {
    guard let i = dirSlashIndex else { return Path("./") }
    return Path(string[..<string.index(after: i)])
  }

  public var nameStem: Path { stem.name }

  public var dirSlashIndex: String.Index? {
    string.lastIndex(of: "/")
  }

  public var nameStartIndex: String.Index {
    if let i = dirSlashIndex {
      return string.index(after: i)
    } else {
      return string.startIndex
    }
  }

  public var nameSubstring: Substring { string[nameStartIndex...] }

  public var nameString: String { String(nameSubstring) }

  public var name: Path { Path(nameString) }

  public var extDotIndex: String.Index? {
    let n = nameSubstring
    guard let i = n.lastIndex(of: ".") else { return nil }
    return (i == n.startIndex) ? nil : i
  }

  public var ext: String {
    if let i = extDotIndex {
      return String(string[i...])
    } else {
      return ""
    }
  }

  public var parts: [String] {
    return string.split(separator: sysPathSepChar, omittingEmptySubsequences: false).map {
      $0.isEmpty ? "/" : String($0)
    }
  }


  public var expandUser: String { Path.expandUser(string: string) }


  public func append(_ suffix: String) -> Path {
    Path(string + suffix)
  }

  public func append(parts: String...) -> Path {
    var allParts = parts
    allParts.prepend(string)
    return Path(allParts.joined(char: sysPathSepChar))
  }

  public func cat(_ paths: Path...) -> Path {
    var parts = [string]
    for path in paths {
      parts.append(path.string)
    }
    return Path(parts.joined(char: sysPathSepChar))
  }

  public func replaceExt(_ ext: String) -> Path {
    var ext = ext
    if let f = ext.first, f != "." {
      ext = "." + ext
    }
    guard let i = extDotIndex else { return Path(string + ext) }
    var s = string
    s.replaceSubrange(i..., with: ext)
    return Path(s)
  }


  public static func ==(l: Path, r: Path) -> Bool { l.string == r.string }


  public static func commonParent<S: Sequence>(_ paths: S) -> Path? where S.Element == Path {
    let commonParts = paths.reduce(intoFirst: { $0?.parts ?? [] }) {
      (commonParts, path) in
      let pathParts = path.parts
      for (i, a, b) in enumZip(commonParts, pathParts) {
        if a != b {
          commonParts.truncate(i)
          break
        }
      }
      if commonParts.count > pathParts.count {
        commonParts.truncate(pathParts.count)
      }
    }
    return commonParts.isEmpty ? nil : Path(parts: commonParts)
  }


  public static func commonParent(_ paths: Path...) -> Path? { commonParent(paths) }


  public static func expandUser(string: String) -> String {
    if string.first != sysHomePrefixChar { return string }
    var s = string
    let slashIndex = s.firstIndex(of: sysPathSepChar) ?? s.endIndex
    let secondIndex = s.index(after: s.startIndex)
    if slashIndex == secondIndex { // bare "~" or "~/…".
      s.replaceSubrange(..<secondIndex, with: userHomeDirNoSlash)
    } else { // "~username" -> "/Users/username".
      s.replaceSubrange(..<secondIndex, with: sysHomeDirString)
    }
    return s
  }

  private static let userHomeDirNoSlash = NSHomeDirectory()

  public static func normalize(string: String) -> String {
    let string = expandUser(string: string)
    var parts: [Substring] = []
    if string.first == "/" { parts.append("") } // Note: must be careful never to pop this leading empty part.
    for part in string.split(separator: sysPathSepChar, omittingEmptySubsequences: true) {
      switch part {
      case ".": continue
      case "..":
        if parts.isEmpty || parts.last == ".." || parts == [""] {
          parts.append(part)
        } else {
          _ = parts.pop()
        }
      default: parts.append(part)
      }
    }
    let isDir = string.hasSuffix(sysPathSep) || parts.last == ".."
    if parts.isEmpty { return isDir ? "./" : "." } // Must be relative, because root-absolute paths have leading empty part.
    if parts == [""] { return "/" } // Need this special case or else end up with double slash.
    // Retain a leading dot in two cases: local executable, or local file with a leading tilde in first part.
    if string.hasPrefix("./") && ((parts.count==1 && !isDir) || parts.first!.hasPrefix("~")) {
      parts.prepend(".")
    }
    if isDir { parts.append("") }
    var s = parts.joined(separator: sysPathSep)
    _ = s.replace(prefix: sysHomeDirString, with: "~")
    _ = s.replace(prefix: "~" + NSUserName(), with: "~")
    return s
  }
}
