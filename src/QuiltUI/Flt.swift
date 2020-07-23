// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import CoreGraphics
import Foundation
import Quilt
import QuiltArithmetic
import QuiltRandom


public typealias Flt = CGFloat

extension Flt: ArithmeticFloat {}


extension Random {

  public func flt(_ max: Flt) -> Flt {
    return Flt(f64(F64(max)))
  }

  public func flt(min: Flt, max: Flt) -> Flt {
    return Flt(f64(min: F64(min), max: F64(max)))
  }

}
