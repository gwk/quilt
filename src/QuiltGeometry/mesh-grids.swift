// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import QuiltVec


public func gridCage(_ divisions: Int, barRatio: Double = 1 / 32) -> Mesh {
  let m = Mesh(name: "gridCage")
  let steps = divisions + 1
  let steps_f = Double(steps)
  for i in 0...steps {
    let t = Double(i * 2) / steps_f - 1
    let pad: Double = barRatio / (steps_f * 2)
    let l = t - pad
    let h = t + pad

    m.addQuad( // back x.
      V3D(-1, l, -1),
      V3D( 1, l, -1),
      V3D( 1, h, -1),
      V3D(-1, h, -1))
    m.addQuad( // front x.
      V3D(-1, l,  1),
      V3D(-1, h,  1),
      V3D( 1, h,  1),
      V3D( 1, l,  1))

    m.addQuad( // bottom x.
      V3D(-1, -1,  l),
      V3D(-1, -1,  h),
      V3D( 1, -1,  h),
      V3D( 1, -1,  l))
    m.addQuad( // top x.
      V3D(-1,  1,  l),
      V3D( 1,  1,  l),
      V3D( 1,  1,  h),
      V3D(-1,  1,  h))

    m.addQuad( // back y.
      V3D( l, -1, -1),
      V3D( h, -1, -1),
      V3D( h,  1, -1),
      V3D( l,  1, -1))
    m.addQuad( // front y.
      V3D( l, -1,  1),
      V3D( l,  1,  1),
      V3D( h,  1,  1),
      V3D( h, -1,  1))
    m.addQuad( // left y.
      V3D(-1, -1,  l),
      V3D(-1,  1,  l),
      V3D(-1,  1,  h),
      V3D(-1, -1,  h))
    m.addQuad( // right y.
      V3D( 1, -1,  l),
      V3D( 1, -1,  h),
      V3D( 1,  1,  h),
      V3D( 1,  1,  l))

    m.addQuad( // left z.
      V3D(-1, l, -1),
      V3D(-1, h, -1),
      V3D(-1, h,  1),
      V3D(-1, l,  1))
    m.addQuad( // right z.
      V3D( 1, l, -1),
      V3D( 1, l,  1),
      V3D( 1, h,  1),
      V3D( 1, h, -1))
    m.addQuad( // bottom z.
      V3D( l, -1, -1),
      V3D( l, -1,  1),
      V3D( h, -1,  1),
      V3D( h, -1, -1))
    m.addQuad( // top z.
      V3D( l,  1,  -1),
      V3D( h,  1,  -1),
      V3D( h,  1,  1),
      V3D( l,  1,  1))
  }
  return m
}
