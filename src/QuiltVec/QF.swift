// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

import simd


public typealias QF = simd_quatf


extension QF: Quaternion {
  public typealias Scalar = Float
  public typealias Vector = V4F
}
