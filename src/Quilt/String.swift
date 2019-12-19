// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public let symbolHeadChars = Set<Character>("_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
public let symbolTailChars = symbolHeadChars.union("0123456789")


extension String: Error {}

extension String {

  public init?<S: Sequence>(bytes: S) where S.Element == UInt8 {
    self.init(bytes: bytes, encoding: .utf8)
  }

  public init<S: Sequence>(utf16: S) where S.Element == UInt16 {
    // TODO: file bug. There should be a constructor that does not require the intermediate copy.
    let a = [UInt16](utf16)
    self.init(utf16CodeUnits: a, count: a.count)
  }

  public init(char: Character, count: Int) {
    self.init(repeating: char, count: count)
  }

  public init?(unicodePoint: UInt8) {
    guard let c = Character(unicodePoint: unicodePoint) else { return nil }
    self.init(c)
  }

  public init?(unicodePoint: UInt16) {
    guard let c = Character(unicodePoint: unicodePoint) else { return nil }
    self.init(c)
  }

  public init?(unicodePoint: UInt32) {
    guard let c = Character(unicodePoint: unicodePoint) else { return nil }
    self.init(c)
  }

  public init(indent: Int) {
    self.init(char: " ", count: indent * 2)
  }

  public var repr: String {
    var r = "\""
    for char in unicodeScalars {
      switch char {
      case "\\": r.append("\\\\")
      case "\"": r.append("\\\"")
      case UnicodeScalar(0x20)...UnicodeScalar(0x7E): r.append(String(char))
      case "\0": r.append("\\0")
      case "\t": r.append("\\t")
      case "\n": r.append("\\n")
      case "\r": r.append("\\r")
      default: r.append("\\{\(String(char.value, radix: 16, uppercase: false))}")
      }
    }
    r.append("\"")
    return r
  }

  // Append variants.

  public mutating func append(_ substring: Substring) { append(contentsOf: substring) }


  // MARK: utilities

  public func contains(string: String, atIndex: Index) -> Bool {
    return contains(sequence: string, atIndex: atIndex)
  }

  public func beforeSuffix(_ suffix: String) -> String? {
    if hasSuffix(suffix) {
      return String(self.dropLast(suffix.count))
    } else {
      return nil
    }
  }

  public func mapChars(_ transform: (Character) -> Character) -> String {
    var s = ""
    for c in self {
      s.append(transform(c))
    }
    return s
  }

  public func mapChars(_ transform: (Character) -> String) -> String {
    var s = ""
    for c in self {
      s.append(transform(c))
    }
    return s
  }

  // MARK: symbols

  public var asSym: String { // TODO: decide if this should be strict; currently quite lax.
    for c0 in self { // do not actually iterate; just get first element.
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
    for c in self {
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

  static let utf16Newline = "\n".utf16.first!

  public var containsNewline: Bool {
    return utf16.contains(String.utf16Newline) // assuming utf16 is the underlying storage, this should be quick.
  }

  public init(lines: [String]) {
    self = lines.joined(separator: "\n")
  }

  public init(lines: String...) {
    self = lines.joined(separator: "\n")
  }

  public var lineCount: Int {
    var count = 0
    for c in self {
      if c == "\n" {
        count += 1
      }
    }
    return count
  }

  public var lines: [Substring] {
    var lines: [Substring] = []
    var lineStart = startIndex
    for idx in indices {
      if self[idx] == "\n" {
        let nextStart = index(after: idx)
        lines.append(self[lineStart..<nextStart])
        lineStart = nextStart
      }
    }
    if lineStart < endIndex {
      lines.append(self[lineStart..<endIndex])
    }
    return lines
  }

  public func numberedLinesFrom(_ from: Int) -> [String] {
    return lines.enumerated().map() { "\($0.offset) \($0.element)" }
  }

  public var numberedLines: [String] { return numberedLinesFrom(1) }


  // MARK: unicode

  public var codes: UnicodeScalarView { return unicodeScalars }


  // MARK: utf8

  public func asUtf8NT<R>(_ body: (Buffer<Int8>) -> R) -> R {
    return utf8CString.withUnsafeBufferPointer(body)
  }

  public func asUtf8NTRaw<R>(_ body: (RawBuffer) -> R) -> R {
    return utf8CString.withUnsafeBufferPointer {
      (buffer: Buffer<Int8>) -> R in
      let raw = RawBuffer(buffer)
      return body(raw)
    }
  }

  // MARK: partition

  public func split(_ separator: Character) -> [String] {
    return split(separator: separator).map() { String($0) }
  }

  /* TODO
  public func split(sub: String) -> [String] {
    return split(separator: sub).map() { String($0) }
  }
 */

  public func strip(char: Character) -> Substring {
    var r = self.range
    while !r.isEmpty && self[r.lowerBound] == char {
      r = index(after: r.lowerBound)..<r.upperBound
    }
    while !r.isEmpty {
      let lastIndex = index(before: r.upperBound)
      if self[lastIndex] != char { break }
      r = r.lowerBound..<lastIndex
    }
    return self[r]
  }
}


public func pluralize(_ count: Int, _ word: String) -> String {
  let s = (count == 1 ? "" : "s")
  return "\(count) \(word)\(s)"
}


public func typeDescription(_ val: Any) -> String {
  return String(describing: type(of: val))
}
