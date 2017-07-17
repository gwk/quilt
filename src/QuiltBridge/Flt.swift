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

extension Random {

  public func flt(_ max: Flt) -> Flt {
    return Flt(f64(F64(max)))
  }

  public func flt(min: Flt, max: Flt) -> Flt {
    return Flt(f64(min: F64(min), max: F64(max)))
  }

}
