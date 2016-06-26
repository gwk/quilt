// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


public typealias F32 = Float
public typealias F64 = Double


public protocol ArithmeticFloat: ArithmeticProtocol, FloatingPoint {
  var sqr: Self { get }
  var sqrt: Self { get }
  var ceil: Self { get }
  var floor: Self { get }
  var round: Self { get }
}


// wrappers around float/double math functions so that we can use overloading properly.
public func sqrt_f(_ f: Float) -> Float { return sqrtf(f) }
public func ceil_f(_ f: Float) -> Float { return ceilf(f) }
public func floor_f(_ f: Float) -> Float { return floorf(f) }
public func round_f(_ f: Float) -> Float { return roundf(f) }

public func sqrt_f(_ d: Double) -> Double { return sqrt(d) }
public func ceil_f(_ d: Double) -> Double { return ceil(d) }
public func floor_f(_ d: Double) -> Double { return floor(d) }
public func round_f(_ d: Double) -> Double { return round(d) }

extension Float: ArithmeticFloat {
  public var sqr: Float { return self * self }
  public var sqrt: Float { return sqrt_f(self) }
  public var ceil: Float { return ceil_f(self) }
  public var floor: Float { return floor_f(self) }
  public var round: Float { return round_f(self) }
}

extension Double: ArithmeticFloat {
  public var sqr: Double { return self * self }
  public var sqrt: Double { return sqrt_f(self) }
  public var ceil: Double { return ceil_f(self) }
  public var floor: Double { return floor_f(self) }
  public var round: Double { return round_f(self) }
}


