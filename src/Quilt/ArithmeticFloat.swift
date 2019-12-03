// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


public typealias F32 = Float
public typealias F64 = Double


extension BinaryFloatingPoint {

  public var asF32: F32 { return F32(self) }
  public var asF64: F64 { return F64(self) }
  public var asInt: Int { return Int(self) }
}

public protocol ArithmeticFloat: ArithmeticProtocol, BinaryFloatingPoint {}

extension F32: ArithmeticFloat {}
extension F64: ArithmeticFloat {}
