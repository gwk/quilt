// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


import Foundation


public protocol Quaternion: CustomDebugStringConvertible, Equatable {

  associatedtype Scalar: SIMDScalar
  associatedtype Vector: FloatVec4 where Vector.Scalar == Scalar
  typealias Vector3 = SIMD3<Scalar>

  var vector: Vector { get set }

  var angle: Vector.Scalar { get }
  var axis: SIMD3<Scalar> { get }


  init()
  init(vector: Vector)
  init(angle: Scalar, axis: Vector3)
  init(from: Vector3, to: Vector3)
}


public extension Quaternion {

  static var dflt: Self { Self(vector: Vector(1, 0, 0, 0)) }

  static var yToNegY: Self { Self(angle: .pi, axis: Vector3(1, 0, 0)) }

  static var yToPosX: Self { Self(angle: -.pi/2, axis: Vector3(0, 0, 1)) }
  static var yToNegX: Self { Self(angle: .pi/2, axis: Vector3(0, 0, 1)) }

  static var yToPosZ: Self { Self(angle: .pi/2, axis: Vector3(1, 0, 0)) }
  static var yToNegZ: Self { Self(angle: -.pi/2, axis: Vector3(1, 0, 0)) }


  var angleAxisDesc: String {
    return "QF(angle: \(angle), axis: \(axis))"
  }
}
