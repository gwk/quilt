// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public let symbolHeadChars = Set<Character>("_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".characters)
public let symbolTailChars = symbolHeadChars.union("0123456789".characters)


extension String {

  public init(char: Character, count: Int) {
    self.init(repeating: String(char), count: count)
  }

  public init(indent: Int) {
    self.init(char: " ", count: indent * 2)
  }

  // MARK: paths

  public var pathExtDotRange: Range<Index>?    { return range(of: ".", options: .backwards) }
  public var pathDirSlashRange: Range<Index>?  { return range(of: "/", options: .backwards) }

  public var pathExt: String {
    if let r = pathExtDotRange {
      return substring(from: r.lowerBound)
    } else {
      return ""
    }
  }

  public var withoutPathExt: String {
    if let r = pathExtDotRange {
      // TODO: check that the range does not span a slash.
      // TODO: allow trailing slash.
      return substring(to: r.lowerBound)
    } else {
      return self
    }
  }

  public func replacePathExt(_ ext: String) -> String {
    var pre: String
    if let r = pathExtDotRange {
      pre = substring(to: r.upperBound)
    } else {
      pre = self + "."
    }
    return pre + ext
  }

  public var pathDir: String {
    if let r = pathDirSlashRange {
      return substring(to: r.lowerBound)
    } else {
      return ""
    }
  }

  public var withoutPathDir: String {
    if let r = pathDirSlashRange {
      return substring(from: r.upperBound)
    } else {
      return self
    }
  }

  public var pathNameStem: String {
    return withoutPathDir.withoutPathExt
  }

  // MARK: urls

  public var fileUrl: URL? { return URL(fileURLWithPath: self, isDirectory: false) }

  public var dirUrl: URL? { return URL(fileURLWithPath: self, isDirectory: true) }

  // MARK: utilities

  public func contains(_ c: Character) -> Bool {
    return self.characters.contains(c)
  }

  public func contains(string: String, atIndex: Index) -> Bool {
    return characters.contains(sequence: string.characters, atIndex: atIndex)
  }

  public func beforeSuffix(_ suffix: String) -> String? {
    if hasSuffix(suffix) {
      return String(self.characters.dropLast(suffix.characters.count))
    } else {
      return nil
    }
  }

  public func mapChars(_ transform: (Character) -> Character) -> String {
    var s = ""
    for c in self.characters {
      s.append(transform(c))
    }
    return s
  }

  public func mapChars(_ transform: (Character) -> String) -> String {
    var s = ""
    for c in self.characters {
      s.append(transform(c))
    }
    return s
  }

  public func replace(_ query: Character, with: Character) -> String {
    return String(characters.replace(query, with: with))
  }

  public func replace(_ query: String, with: String) -> String {
    return String(characters.replace(query.characters, with: with.characters))
  }

  // MARK: symbols

  public var asSym: String { // TODO: decide if this should be strict; currently quite lax.
    for c0 in self.characters { // do not actually iterate; just get first element.
      if c0.isDigit {
        return "_" + mapChars() { symbolTailChars.contains($0) ? $0 : "_" }
      } else {
        return mapChars() { symbolTailChars.contains($0) ? $0 : "_" }
      }
    }
    return "" // empty case.
  }

  public var isSym: Bool { // TODO: allow unicode characters?
    if isEmpty {
      return false
    }
    var first = true
    for c in self.characters {
      if first {
        first = false
        if !symbolHeadChars.contains(c) {
          return false
        }
      } else {
        if !symbolTailChars.contains(c) {
          return false
        }
      }
    }
    return true
  }

  // MARK: lines

  public init(lines: [String]) {
    self = lines.joined(separator: "\n")
  }

  public init(lines: String...) {
    self = lines.joined(separator: "\n")
  }

  public var lineCount: Int {
    var count = 0
    for c in self.characters {
      if c == "\n" {
        count += 1
      }
    }
    return count
  }

  public var lines: [String] {
    let charLines = self.characters.split(separator: "\n", omittingEmptySubsequences: false)
    return charLines.map { String($0) }
  }

  public func numberedLinesFrom(_ from: Int) -> [String] {
    return lines.enumerated().map() { (i, line) in " \(line)" }
  }

  public var numberedLines: [String] { return numberedLinesFrom(1) }


  // MARK: unicode

  public var codes: UnicodeScalarView { return unicodeScalars }


  // MARK: utf8

  public func asUtf8NT<R>(_ body: (UnsafeBufferPointer<Int8>) -> R) -> R {
    return utf8CString.withUnsafeBufferPointer(body)
  }

#if false
  public func asUtf8NTUns<R>(_ body: (UnsafeBufferPointer<UInt8>) -> R) -> R {
    return utf8CString.withUnsafeBufferPointer {
      (buffer: UnsafeBufferPointer<CChar>) -> R in
      return buffer.baseAddress!.withMemoryRebound(to: UInt8.self, capacity: buffer.count) {
        (reboundPtr: UnsafeMutablePointer<UInt8>) -> R in
        return body(UnsafeBufferPointer(start: reboundPtr, count: buffer.count))
      }
    }
  }
#endif

  public func asUtf8NTRaw<R>(_ body: (UnsafeRawBufferPointer) -> R) -> R {
    return utf8CString.withUnsafeBufferPointer {
      (buffer: UnsafeBufferPointer<Int8>) -> R in
      let raw = UnsafeRawBufferPointer(buffer)
      return body(raw)
    }
  }

  // MARK: partition

  public func part(_ sep: String) -> (String, String)? {
    if let (a, b) = characters.part(sep.characters) {
      return (String(a), String(b))
    }
    return nil
  }

  public func split(_ separator: Character) -> [String] {
    return characters.split(separator: separator).map() { String($0) }
  }

  /* TODO
  public func split(sub: String) -> [String] {
    return characters.split(separator: sub.characters).map() { String($0) }
  }
 */
}


public func pluralize(_ count: Int, _ word: String) -> String {
  let s = (count == 1 ? "" : "s")
  return "\(count) \(word)\(s)"
}

