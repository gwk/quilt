// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import simd


public typealias QF = simd_quatf


extension QF: Quaternion {
  public typealias Scalar = Float
  public typealias Vector = V4F
}
