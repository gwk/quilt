// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public protocol JsonArrayInitable {
  init(jsonArray: JsonArray) throws
}


extension JsonArrayInitable {
  public init(json: JsonType) throws {
    let jsonArray = try JsonArray(json: json)
    try self.init(jsonArray: jsonArray)
  }
}


extension JsonType {
  public func asArray() throws -> JsonArray {
    guard let a = self as? NSArray else {
      throw Json.Err.unexpectedType(exp: JsonArray.self, json: self)
    }
    return JsonArray(raw: a)
  }

  public func convArray<T: JsonArrayInitable>() throws -> T {
    return try T(jsonArray: try asArray())
  }
}


public struct JsonArray: JsonInitable {
  public let raw: NSArray

  public init(raw: NSArray) { self.raw = raw }

  public init(json: JsonType) throws {
    if let raw = json as? NSArray {
      self.init(raw: raw)
    } else { throw Json.Err.unexpectedType(exp: NSArray.self, json: json) }
  }

  public init(anyJson: JsonType) { // for non-array input, create an array of one element.
    self.init(raw: (anyJson as? NSArray) ?? NSArray(object: anyJson))
  }

  public init(data: Data) throws { self.init(raw: try Json.fromData(data)) }

  public init(stream: InputStream) throws { self.init(raw: try Json.fromStream(stream)) }

  public init(path: String) throws { self.init(raw: try Json.fromPath(path)) }

  public var count: Int { return raw.count }

  public subscript(index: Int) -> JsonType {
    return raw[index] as! JsonType
  }

  public func el(_ index: Int) throws -> JsonType {
    if index >= count { throw Json.Err.missingEl(index: index, json: raw) }
    return raw[index] as! JsonType
  }

  public func last(_ index: Int) throws -> JsonType {
    let end = index + 1
    if end != count { throw Json.Err.unexpectedCount(expCount: end, json: raw) }
    return raw[index] as! JsonType
  }

  public func convEls<T: JsonInitable>(start: Int = 0, end: Int? = nil) throws -> [T] {
    let end = end ?? raw.count
    if end > count { throw Json.Err.missingEl(index: count, json: raw) }
    let range = start..<end
    return try range.map { try T.init(json: raw[$0] as! JsonType) }
  }

  public func convArrays<T: JsonArrayInitable>(start: Int = 0, end: Int? = nil) throws -> [T] {
    let end = end ?? raw.count
    if end > count { throw Json.Err.missingEl(index: count, json: raw) }
    let range = start..<end
    return try range.map { try T.init(jsonArray: try JsonArray(json: raw[$0] as! JsonType)) }
  }

  public func convDicts<T: JsonDictInitable>(start: Int = 0, end: Int? = nil) throws -> [T] {
    let end = end ?? raw.count
    if end > count { throw Json.Err.missingEl(index: count, json: raw) }
    let range = start..<end
    return try range.map { try T.init(jsonDict: try JsonDict(json: raw[$0] as! JsonType)) }
  }
}
