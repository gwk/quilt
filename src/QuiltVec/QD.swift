// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

import simd


public typealias QD = simd_quatd


extension QD: Quaternion {
  public typealias Scalar = Double
  public typealias Vector = V4D
}
