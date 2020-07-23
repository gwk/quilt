// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import simd
import QuiltArithmetic


public protocol PixelType {
  associatedtype Scalar
  var scalarCount: Int { get }
  static var scalarCount: Int { get }
}

extension U8: PixelType {
  public typealias Scalar = U8
  public var scalarCount: Int { return 1 }
  public static var scalarCount: Int { return 1 }
}

extension F32: PixelType {
  public typealias Scalar = F32
  public var scalarCount: Int { return 1 }
  public static var scalarCount: Int { return 1 }
}

extension SIMD2: PixelType where Scalar: ArithmeticFloat {}
extension SIMD3: PixelType where Scalar: ArithmeticFloat {}
extension SIMD4: PixelType where Scalar: ArithmeticFloat {}
