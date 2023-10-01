// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import simd
import QuiltArithmetic


public typealias QD = simd_quatd


extension QD: Quaternion {
  public typealias Scalar = Double
  public typealias Vector = V4D
}
