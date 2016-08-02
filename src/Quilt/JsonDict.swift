// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public protocol JsonDictInitable {
  init(jsonDict: JsonDict) throws
}


extension JsonDictInitable {
  public init(json: JsonType) throws {
    let jsonDict = try JsonDict(json: json)
    try self.init(jsonDict: jsonDict)
  }
}


public protocol JsonDictItemInitable {
  init(key: String, json: JsonType) throws
}


extension JsonType {
  public func asDict() throws -> JsonDict {
    guard let d = self as? NSDictionary else {
      throw Json.Err.unexpectedType(exp: JsonDict.self, json: self)
    }
    return JsonDict(raw: d)
  }

  public func convDict<T: JsonDictInitable>() throws -> T {
    return try T(jsonDict: try asDict())
  }
}


public struct JsonDict: JsonInitable {
  public let raw: NSDictionary

  public init(raw: NSDictionary) { self.raw = raw }

  public init(json: JsonType) throws {
    if let raw = json as? NSDictionary {
      self.init(raw: raw)
    } else { throw Json.Err.unexpectedType(exp: NSDictionary.self, json: json) }
  }

  public init(data: Data) throws { self.init(raw: try Json.fromData(data)) }

  public init(stream: InputStream) throws { self.init(raw: try Json.fromStream(stream)) }

  public init(path: String) throws { self.init(raw: try Json.fromPath(path)) }

  public subscript(key: String) -> JsonType? {
    return raw[key] as! JsonType?
  }

  public func contains(_ key: String) -> Bool {
    return raw[key] != nil
  }

  public func get(_ key: String) throws -> JsonType {
    guard let val = raw[key] else { throw Json.Err.key(key: key, json: raw) }
    return val as! JsonType
  }

  public func convItems<T: JsonDictItemInitable>() throws -> [T] {
    return try raw.map { try T.init(key: $0.0 as! String, json: $0.1 as! JsonType) }
  }

  public func mapVals<V>(transform: (JsonType) throws -> V) rethrows -> [String:V] {
    var d: [String:V] = [:]
    for (k, v) in raw {
      d[k as! String] = try transform(v as! JsonType)
    }
    return d
  }
}
