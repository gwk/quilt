// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public protocol JsonType: AnyObject {}
public protocol JsonRootType: JsonType {}
public protocol JsonLeafType: JsonType {}

extension NSArray: JsonRootType {}
extension NSDictionary: JsonRootType {}

extension NSNumber: JsonLeafType {}
extension NSString: JsonLeafType {}
extension NSNull: JsonLeafType {}

public enum Json {

  public enum Err: Error {
    case conversion(exp: Any.Type, json: JsonType) // error in converting the json value to the expected type.
    case key(key: String, json: JsonType)
    case missingEl(index: Int, json: JsonType) // array is too short.
    case other(Error)
    case path(String, Error)
    case unexpectedCount(expCount: Int, json: JsonType) // array is wrong length.
    case unexpectedType(exp: Any.Type, json: JsonType)
  }

  //case Null
  //case Number(NSNumber)
  //case String(NSString)
  //case Array(NSArray)
  //case Dictionary(NSDictionary)

  public static func fromData<T: JsonType>(_ data: Data, options: JSONSerialization.ReadingOptions = []) throws -> T {
    let json: JsonType
    do {
      json = try JSONSerialization.jsonObject(with: data, options: options) as! JsonType
    } catch let e {
      throw Err.other(e)
    }
    if let json = json as? T {
      return json
    }
    throw Err.unexpectedType(exp: T.self, json: json)
  }

  public static func fromStream<T: JsonType>(_ stream: InputStream, options: JSONSerialization.ReadingOptions = []) throws -> T {
    let json: JsonType
    do {
      if stream.streamStatus == .notOpen {
        stream.open()
      }
      json = try JSONSerialization.jsonObject(with: stream, options: options) as! JsonType
    } catch let e {
      throw Err.other(e)
    }
    if let json = json as? T {
      return json
    }
    throw Err.unexpectedType(exp: T.self, json: json)
  }

  public static func fromPath<T: JsonType>(_ path: String, options: JSONSerialization.ReadingOptions = []) throws -> T {
    var data: Data
    do {
      data = try Data(contentsOf: URL(fileURLWithPath: path))
    } catch let e { throw Err.path(path, e) }
    return try fromData(data, options: options)
  }
}
