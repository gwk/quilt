// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import QuiltUI
import QuiltSceneKit


extension Mesh {

  public static var globeIcosahedralVertices: [V3] = { () in
    // Returns 12 icosohedral vertices with radius of 1.
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

    // Right-handed coordinate system. +Z is near (towards camera).
    // Each ring of five vertices is ordered clockwise.
    // The vertices with z=0 are labeled "head".
    return [
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
  }()


  public static var globeStripIndices: [[Int]] = [
    [0, 2, 1,  9,  8, 11],
    [0, 3, 2, 10,  9, 11],
    [0, 4, 3,  6, 10, 11],
    [0, 5, 4,  7,  6, 11],
    [0, 1, 5,  8,  7, 11],
  ]


  public class func globe() -> Mesh {
    // Returns a globe with vertex radius of 1.
    // It is essentially an icosahedron, but differs from Mesh.icosahedron:
    // * The globe has "polar" vertices that are positioned at the -y and +y axes.
    // * It consists of five four-triangle strips, from south to north pole.
    // * Each strip has independent vertices so that they can have different texture coordinates.

    // From a standard icosahedron construction:
    // Each icosahedron vertex is also the vertex of an axis-aligned golden rectangle.
    // Compute the golden rectangle hypotenuse use that to normalize major and minor lengths so that we get a unit.

    let mesh = Mesh(name: "globe")
    mesh.textures.append([])

    let v = Mesh.globeIcosahedralVertices

    for (i, indices) in Mesh.globeStripIndices.enumerated() {

      // Positions.
      let positions = indices.map({v[$0]})
      let vi = mesh.vertexCount
      mesh.positions.append(contentsOf: positions)

      // Textures.
      let u0 = Flt(i) * 0.2
      let u1 = u0 + 0.2
      let texCoords = [
        V2(u0, 0.0), V2(u1, 0.0),
        V2(u0, 0.5), V2(u1, 0.5),
        V2(u0, 1.0), V2(u1, 1.0),
      ]
      mesh.textures[0].append(contentsOf: texCoords)

      // Triangles.
      let triangles = [
        Tri(vi+0, vi+2, vi+1),
        Tri(vi+1, vi+2, vi+3),
        Tri(vi+2, vi+4, vi+3),
        Tri(vi+3, vi+4, vi+5),
      ]
      let ti = mesh.triangles.count
      mesh.triangles.append(contentsOf: triangles)

      // Edges.
      let edges = [
        Edge(va: vi+0, vb: vi+2, tl: ti+0, tr: -1),
        Edge(va: vi+2, vb: vi+4, tl: ti+2, tr: -1),
        Edge(va: vi+4, vb: vi+5, tl: ti+3, tr: -1),
        Edge(va: vi+5, vb: vi+3, tl: ti+3, tr: -1),
        Edge(va: vi+3, vb: vi+1, tl: ti+1, tr: -1),
        Edge(va: vi+1, vb: vi+0, tl: ti+0, tr: -1),

        Edge(va: vi+1, vb: vi+2, tl: ti+1, tr: ti+0),
        Edge(va: vi+2, vb: vi+3, tl: ti+1, tr: ti+2),
        Edge(va: vi+3, vb: vi+4, tl: ti+3, tr: ti+2),
      ]
      mesh.edges.append(contentsOf: edges)
    }

    mesh.addNormalsFromOriginToPositions()
    return mesh
  }
}
