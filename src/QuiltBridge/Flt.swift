// © 2014 George King. Permission to use this file is granted in license-qk.txt.

import CoreGraphics
import Foundation
import Quilt


public typealias Flt = CGFloat

extension Flt: ArithmeticFloat {
  public var sqr: Flt { return self * self }
  public var sqrt: Flt { return Flt(native.sqrt) }
  public var ceil: Flt { return Flt(native.ceil) }
  public var floor: Flt { return Flt(native.floor) }
  public var round: Flt { return Flt(native.round) }
}

extension Flt: JsonInitable {
  public init(json: JsonType) throws {
    if let n = json as? NSNumber {
      self = n as Flt
    } else if let s = json as? NSString {
      if let n = NativeType(s as String) {
        self = Flt(n)
      } else { throw Json.Err.conversion(exp: Flt.self, json: json) }
    } else { throw Json.Err.unexpectedType(exp: Flt.self, json: json) }
  }
}

extension Random {

  public func flt(_ max: Flt) -> Flt {
    return Flt(f64(F64(max)))
  }

  public func flt(min: Flt, max: Flt) -> Flt {
    return Flt(f64(min: F64(min), max: F64(max)))
  }

}
