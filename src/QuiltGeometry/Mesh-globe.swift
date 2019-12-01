// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import QuiltUI
import QuiltSceneKit


extension Mesh {

  class func globe() -> Mesh {
    // Returns a globe with vertex radius of 1.
    // It is essentially an icosahedron, but differs from Mesh.icosahedron:
    // * The globe has "polar" vertices that are positioned at the -y and +y axes.
    // * It consists of five four-triangle strips, from south to north pole.
    // * Each strip has independent vertices so that they can have different texture coordinates.

    // From a standard icosahedron construction:
    // Each icosahedron vertex is also the vertex of an axis-aligned golden rectangle.
    // Compute the golden rectangle hypotenuse use that to normalize major and minor lengths so that we get a unit.

    let phi: Flt = (1 + sqrt(5)) * 0.5 // golden ratio.
    let golden_rect_hyp = sqrt(phi * phi + 1)
    let m = phi / golden_rect_hyp // Major.
    let n = 1.0 / golden_rect_hyp // Minor.

    // The globe construction rotates this icosahedron around the z axis to place polar vertices on the y axis.
    // The first term was originally derived as the y component by rotating (0, n).
    // x.sqr + y.sqr = n.sqr; x/y = phi.
    let a3 = n / sqrt(1 + phi.sqr) // 0.276393202250021
    let y = phi * a3 // 0.4472135954999579
    let b7 = phi * y // 0.7236067977499789
    let c9 = 2 * y // 0.8944271909999159

    let mesh = Mesh(name: "globe")
    mesh.textures.append([])

    // Right-handed coordinate system. +Z is near (towards camera).
    // Each ring of five vertices is ordered clockwise.
    // The vertices with z=0 are labeled "head".
    let v:[V3] = [
      V3(  0,  1,  0), // 11. North pole.
      V3( c9,  y,  0), // 6. North head.
      V3( a3,  y, -m), // 10. North far arm.
      V3(-b7,  y, -n), // 9. North far leg.
      V3(-b7,  y,  n), // 8. North near leg.
      V3( a3,  y,  m), // 7. North near arm.
      V3(-c9, -y,  0), // 1. South head.
      V3(-a3, -y,  m), // 5. South near arm.
      V3( b7, -y,  n), // 4. South near leg.
      V3( b7, -y, -n), // 3. South far leg.
      V3(-a3, -y, -m), // 2. South far arm.
      V3(  0, -1,  0), // 0. South pole.
    ]

    let stripIndices = [
      [0, 2, 1,  9,  8, 11],
      [0, 3, 2, 10,  9, 11],
      [0, 4, 3,  6, 10, 11],
      [0, 5, 4,  7,  6, 11],
      [0, 1, 5,  8,  7, 11],
    ]

    for (i, indices) in stripIndices.enumerated() {
      let vi = mesh.vertexCount
      //let vo = indices.map({v[$0]}) // TEMP.
      //let c = (vo[0]+vo[1]+vo[2]+vo[3]+vo[4]+vo[5]).norm * 0.1 // TEMP.
      let vs = indices.map({v[$0]})
      mesh.positions.append(contentsOf: vs)

      let uv_fudge_in: Flt = 0.01
      let u0 = Flt(i) * 0.2 + uv_fudge_in
      let u1 = u0 + 0.2 - uv_fudge_in
      let ts = [
        V2(u0, 0.0), V2(u1, 0.0),
        V2(u0, 0.5), V2(u1, 0.5),
        V2(u0, 1.0), V2(u1, 1.0),
      ]
      mesh.textures[0].append(contentsOf: ts)
      let tris = [
        Tri(vi+0, vi+2, vi+1),
        Tri(vi+1, vi+2, vi+3),
        Tri(vi+2, vi+4, vi+3),
        Tri(vi+3, vi+4, vi+5),
      ]
      mesh.triangles.append(contentsOf: tris)
    }
    //mesh.addAllSegments()
    //mesh.segments.sort()
    //mesh.addTrianglesFromSegments()
    mesh.addNormalsFromOriginToPositions()
    return mesh
  }

}
