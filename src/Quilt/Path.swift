// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public struct Path: Equatable {

  public let string: String

  public init?(_ string: String) {
    guard let s = Path.normalize(string: string) else { return nil }
    self.string = s
  }

  public init?(_ url: URL) {
    assert(url.isFileURL)
    guard let s = Path(url.path) else { return nil }
    self = s
  }

  public var description: String { return string }


  public static func ==(l: Path, r: Path) -> Bool { return l.string == r.string }


  public static func normalize(string: String) -> String? {
    if string.isEmpty { return nil }
    var comps: [Substring] = []
    if string.hasPrefix(sysPathSep) { comps.append("") }
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
    if comps.isEmpty { return "." }
    if string.hasSuffix(sysPathSep) { comps.append("") }
    return comps.joined(separator: String(sysPathSep))
  }
}