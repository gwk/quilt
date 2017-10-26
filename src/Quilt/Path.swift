// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public struct Path: Equatable, ExpressibleByStringLiteral {

  public typealias StringLiteralType = String

  public let string: String

  public init(_ string: String) {
    self.string = Path.normalize(string: string)
  }

  public init(_ substring: Substring) {
    self.string = Path.normalize(string: String(substring))
  }

  public init(_ url: URL) {
    precondition(url.isFileURL)
    self = Path(url.path)
  }

  public init(stringLiteral: StringLiteralType) {
    self = Path(stringLiteral)
  }

  public var description: String { return string }

  public var url: URL { return URL(fileURLWithPath: string) }

  public var isRootAbs: Bool { return string.first == sysPathSepChar }

  public var isUserAbs: Bool { return string.first == sysHomePrefixChar }

  public var isAbs: Bool { return isRootAbs || isUserAbs }

  public var isRel: Bool { return !isAbs }

  public var hasDirSuffix: Bool { return string.last == sysPathSepChar }

  public var stem: Path {
    // The "stem" is the portion of the path up to the '.ext' extension.
    guard let i = extDotIndex else { return self }
    return Path(string[..<i])
  }

  public var dir: Path {
    guard let i = dirSlashIndex else { return Path("./") }
    return Path(string[..<string.index(after: i)])
  }

  public var nameStem: Path { return stem.name }

  public var dirSlashIndex: String.Index? {
    return string.index(ofLast: "/")
  }

  public var nameStartIndex: String.Index {
    if let i = dirSlashIndex {
      return string.index(after: i)
    } else {
      return string.startIndex
    }
  }

  public var nameSubstring: Substring { return string[nameStartIndex...] }

  public var nameString: String { return String(nameSubstring) }

  public var name: Path { return Path(nameString) }

  public var extDotIndex: String.Index? {
    let n = nameSubstring
    guard let i = n.index(ofLast: ".") else { return nil }
    return (i == n.startIndex) ? nil : i
  }

  public var ext: String {
    if let i = extDotIndex {
      return String(string[i...])
    } else {
      return ""
    }
  }

  public func append(_ suffix: String) -> Path {
    return Path(string + suffix)
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


  public static func ==(l: Path, r: Path) -> Bool { return l.string == r.string }


  public static func normalize(string: String) -> String {
    var comps: [Substring] = []
    for comp in string.split(separator: sysPathSepChar, omittingEmptySubsequences: true) {
      switch comp {
      case ".": continue
      case "..":
        if comps.isEmpty {
          comps.append(comp)
        } else if let l = comps.last, l == ".." {
          comps.append(comp)
        } else {
          _ = comps.pop()
        }
      default: comps.append(comp)
      }
    }
    let isRootAbs = string.hasPrefix(sysPathSep)
    let isDir = string.hasSuffix(sysPathSep)
    if comps.isEmpty {
      if isRootAbs { return "/" }
      if isDir { return "./" }
      return "."
    }
    if isRootAbs { comps.prepend("") }
    if string.hasSuffix(sysPathSep) { comps.append("") }
    return comps.joined(separator: String(sysPathSep))
  }
}
