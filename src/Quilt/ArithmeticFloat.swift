// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


public typealias F32 = Float
public typealias F64 = Double


extension BinaryFloatingPoint {
  public var sqr: Self { return self * self }
  public var sqrt: Self { return self.squareRoot() }
  public var ceil: Self { return Darwin.ceil(self) }
  public var floor: Self { return Darwin.floor(self) }
  public var rnd: Self { return self.rounded() }
}


public protocol ArithmeticFloat: ArithmeticProtocol, BinaryFloatingPoint {}

extension F32: ArithmeticFloat {}
extension F64: ArithmeticFloat {}
