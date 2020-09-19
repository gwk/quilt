// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import QuiltVec


extension Mesh {

  public class func tetrahedron() -> Mesh {
    // returns a tetrahedron with vertex radius of 1.
    let r: Double = sqrt(1.0 / 3.0) // radius of insphere.
    let mesh = Mesh(name: "tetrahedron")

    mesh.positions = [
      V3D(-r, -r, -r), // Cube vertex index 0.
      V3D(-r,  r,  r), // Cube vertex index 3.
      V3D( r, -r,  r), // Cube vertex index 5.
      V3D( r,  r, -r)] // Cube vertex index 6.

    mesh.triangles = [
      Tri(0, 1, 3),
      Tri(0, 2, 1),
      Tri(0, 3, 2),
      Tri(1, 2, 3)]

    mesh.edges = [
      Edge(va: 0, vb: 1, tl: 0, tr: 1),
      Edge(va: 0, vb: 2, tl: 1, tr: 2),
      Edge(va: 0, vb: 3, tl: 2, tr: 0),
      Edge(va: 1, vb: 2, tl: 3, tr: 1),
      Edge(va: 1, vb: 3, tl: 0, tr: 3),
      Edge(va: 2, vb: 3, tl: 3, tr: 2)]

    mesh.addSegmentsFromEdges()
    mesh.addNormalsFromOriginToPositions()
    return mesh
  }


  public class func cube() -> Mesh {
    // returns a cube with vertex radius of 1.
    let r: Double = sqrt(1.0 / 3.0) // radius of insphere.
    let mesh = Mesh(name: "cube")

    mesh.positions = [
      V3D(-r, -r, -r),
      V3D(-r, -r,  r),
      V3D(-r,  r, -r),
      V3D(-r,  r,  r),
      V3D( r, -r, -r),
      V3D( r, -r,  r),
      V3D( r,  r, -r),
      V3D( r,  r,  r)]

    mesh.segments = [
      Seg(0, 1),
      Seg(0, 2),
      Seg(0, 4),
      Seg(1, 3),
      Seg(1, 5),
      Seg(2, 3),
      Seg(2, 6),
      Seg(3, 7),
      Seg(4, 5),
      Seg(4, 6),
      Seg(5, 7),
      Seg(6, 7)]

    mesh.triangles = [
      Tri(0, 1, 3),
      Tri(0, 2, 6),
      Tri(0, 3, 2),
      Tri(0, 4, 5),
      Tri(0, 5, 1),
      Tri(0, 6, 4),
      Tri(1, 5, 7),
      Tri(1, 7, 3),
      Tri(2, 3, 7),
      Tri(2, 7, 6),
      Tri(4, 6, 7),
      Tri(4, 7, 5)]

    mesh.edges = [
      Edge(va: 0, vb: 1, tl: 0, tr: 4),
      Edge(va: 0, vb: 2, tl: 1, tr: 2),
      Edge(va: 0, vb: 3, tl: 2, tr: 0),
      Edge(va: 0, vb: 4, tl: 3, tr: 5),
      Edge(va: 0, vb: 5, tl: 4, tr: 3),
      Edge(va: 0, vb: 6, tl: 5, tr: 1),
      Edge(va: 1, vb: 3, tl: 0, tr: 7),
      Edge(va: 1, vb: 5, tl: 6, tr: 4),
      Edge(va: 1, vb: 7, tl: 7, tr: 6),
      Edge(va: 2, vb: 3, tl: 8, tr: 2),
      Edge(va: 2, vb: 6, tl: 1, tr: 9),
      Edge(va: 2, vb: 7, tl: 9, tr: 8),
      Edge(va: 3, vb: 7, tl: 8, tr: 7),
      Edge(va: 4, vb: 5, tl: 3, tr: 11),
      Edge(va: 4, vb: 6, tl: 10, tr: 5),
      Edge(va: 4, vb: 7, tl: 11, tr: 10),
      Edge(va: 5, vb: 7, tl: 6, tr: 11),
      Edge(va: 6, vb: 7, tl: 10, tr: 9)]

    mesh.addNormalsFromOriginToPositions()
    return mesh
  }


  public class func octahedron() -> Mesh {
    // returns an octahedron with vertex radius of 1.
    let mesh = Mesh(name: "octahedron")
    mesh.positions = [
      V3D(-1, -0,  0),
      V3D( 0, -1,  0),
      V3D( 0,  0, -1),
      V3D( 0,  0,  1),
      V3D( 0,  1,  0),
      V3D( 1,  0,  0)]

    mesh.triangles = [
      Tri(0, 1, 3),
      Tri(0, 2, 1),
      Tri(0, 3, 4),
      Tri(0, 4, 2),
      Tri(1, 2, 5),
      Tri(1, 5, 3),
      Tri(2, 4, 5),
      Tri(3, 5, 4)]

    mesh.edges = [
      Edge(va: 0, vb: 1, tl: 0, tr: 1),
      Edge(va: 0, vb: 2, tl: 1, tr: 3),
      Edge(va: 0, vb: 3, tl: 2, tr: 0),
      Edge(va: 0, vb: 4, tl: 3, tr: 2),
      Edge(va: 1, vb: 2, tl: 4, tr: 1),
      Edge(va: 1, vb: 3, tl: 0, tr: 5),
      Edge(va: 1, vb: 5, tl: 5, tr: 4),
      Edge(va: 2, vb: 4, tl: 6, tr: 3),
      Edge(va: 2, vb: 5, tl: 4, tr: 6),
      Edge(va: 3, vb: 4, tl: 2, tr: 7),
      Edge(va: 3, vb: 5, tl: 7, tr: 5),
      Edge(va: 4, vb: 5, tl: 6, tr: 7)]

    mesh.addSegmentsFromEdges()
    mesh.addNormalsFromOriginToPositions()
    return mesh
  }


  public class func dodecahedron() -> Mesh {
    // returns a dodecahedron with vertex radius of 1.
    let r: Double = sqrt(1.0 / 3.0) // radius of cube insphere.
    let phi: Double = (1 + sqrt(5)) * 0.5 // golden ratio.
    // two types of vertices: cubic and axis-aligned rect.
    // rect major and minor are (phi, 1 / phi) for unit cube; must normalize by x.
    let m: Double = r * phi // major.
    let n: Double = r / phi // minor.
    let mesh = Mesh(name: "dodecahedron")

    mesh.positions = [
      V3D(-m, -n,  0),
      V3D(-m,  n,  0),
      V3D(-r, -r, -r),
      V3D(-r, -r,  r),
      V3D(-r,  r, -r),
      V3D(-r,  r,  r),
      V3D(-n,  0, -m),
      V3D(-n,  0,  m),
      V3D( 0, -m, -n),
      V3D( 0, -m,  n),
      V3D( 0,  m, -n),
      V3D( 0,  m , n),
      V3D( n,  0, -m),
      V3D( n,  0,  m),
      V3D( r, -r, -r),
      V3D( r, -r,  r),
      V3D( r,  r, -r),
      V3D( r,  r,  r),
      V3D( m, -n,  0),
      V3D( m,  n,  0)]

    mesh.segments = [
      Seg(0, 1),
      Seg(0, 2),
      Seg(0, 3),
      Seg(1, 4),
      Seg(1, 5),
      Seg(2, 6),
      Seg(2, 8),
      Seg(3, 7),
      Seg(3, 9),
      Seg(4, 6),
      Seg(4, 10),
      Seg(5, 7),
      Seg(5, 11),
      Seg(6, 12),
      Seg(7, 13),
      Seg(8, 9),
      Seg(8, 14),
      Seg(9, 15),
      Seg(10, 11),
      Seg(10, 16),
      Seg(11, 17),
      Seg(12, 14),
      Seg(12, 16),
      Seg(13, 15),
      Seg(13, 17),
      Seg(14, 18),
      Seg(15, 18),
      Seg(16, 19),
      Seg(17, 19),
      Seg(18, 19)]

    mesh.triangles = [
      Tri(0, 1, 4),
      Tri(0, 2, 8),
      Tri(0, 3, 7),
      Tri(0, 4, 6),
      Tri(0, 5, 1),
      Tri(0, 6, 2),
      Tri(0, 7, 5),
      Tri(0, 8, 9),
      Tri(0, 9, 3),
      Tri(1, 5, 11),
      Tri(1, 10, 4),
      Tri(1, 11, 10),
      Tri(2, 6, 12),
      Tri(2, 12, 14),
      Tri(2, 14, 8),
      Tri(3, 9, 15),
      Tri(3, 13, 7),
      Tri(3, 15, 13),
      Tri(4, 10, 16),
      Tri(4, 12, 6),
      Tri(4, 16, 12),
      Tri(5, 7, 13),
      Tri(5, 13, 17),
      Tri(5, 17, 11),
      Tri(8, 14, 18),
      Tri(8, 15, 9),
      Tri(8, 18, 15),
      Tri(10, 11, 17),
      Tri(10, 17, 19),
      Tri(10, 19, 16),
      Tri(12, 16, 19),
      Tri(12, 18, 14),
      Tri(12, 19, 18),
      Tri(13, 15, 18),
      Tri(13, 18, 19),
      Tri(13, 19, 17)]

    mesh.edges = [
      Edge(va: 0, vb: 1, tl: 0, tr: 4),
      Edge(va: 0, vb: 2, tl: 1, tr: 5),
      Edge(va: 0, vb: 3, tl: 2, tr: 8),
      Edge(va: 0, vb: 4, tl: 3, tr: 0),
      Edge(va: 0, vb: 5, tl: 4, tr: 6),
      Edge(va: 0, vb: 6, tl: 5, tr: 3),
      Edge(va: 0, vb: 7, tl: 6, tr: 2),
      Edge(va: 0, vb: 8, tl: 7, tr: 1),
      Edge(va: 0, vb: 9, tl: 8, tr: 7),
      Edge(va: 1, vb: 4, tl: 0, tr: 10),
      Edge(va: 1, vb: 5, tl: 9, tr: 4),
      Edge(va: 1, vb: 10, tl: 10, tr: 11),
      Edge(va: 1, vb: 11, tl: 11, tr: 9),
      Edge(va: 2, vb: 6, tl: 12, tr: 5),
      Edge(va: 2, vb: 8, tl: 1, tr: 14),
      Edge(va: 2, vb: 12, tl: 13, tr: 12),
      Edge(va: 2, vb: 14, tl: 14, tr: 13),
      Edge(va: 3, vb: 7, tl: 2, tr: 16),
      Edge(va: 3, vb: 9, tl: 15, tr: 8),
      Edge(va: 3, vb: 13, tl: 16, tr: 17),
      Edge(va: 3, vb: 15, tl: 17, tr: 15),
      Edge(va: 4, vb: 6, tl: 3, tr: 19),
      Edge(va: 4, vb: 10, tl: 18, tr: 10),
      Edge(va: 4, vb: 12, tl: 19, tr: 20),
      Edge(va: 4, vb: 16, tl: 20, tr: 18),
      Edge(va: 5, vb: 7, tl: 21, tr: 6),
      Edge(va: 5, vb: 11, tl: 9, tr: 23),
      Edge(va: 5, vb: 13, tl: 22, tr: 21),
      Edge(va: 5, vb: 17, tl: 23, tr: 22),
      Edge(va: 6, vb: 12, tl: 12, tr: 19),
      Edge(va: 7, vb: 13, tl: 21, tr: 16),
      Edge(va: 8, vb: 9, tl: 7, tr: 25),
      Edge(va: 8, vb: 14, tl: 24, tr: 14),
      Edge(va: 8, vb: 15, tl: 25, tr: 26),
      Edge(va: 8, vb: 18, tl: 26, tr: 24),
      Edge(va: 9, vb: 15, tl: 15, tr: 25),
      Edge(va: 10, vb: 11, tl: 27, tr: 11),
      Edge(va: 10, vb: 16, tl: 18, tr: 29),
      Edge(va: 10, vb: 17, tl: 28, tr: 27),
      Edge(va: 10, vb: 19, tl: 29, tr: 28),
      Edge(va: 11, vb: 17, tl: 27, tr: 23),
      Edge(va: 12, vb: 14, tl: 13, tr: 31),
      Edge(va: 12, vb: 16, tl: 30, tr: 20),
      Edge(va: 12, vb: 18, tl: 31, tr: 32),
      Edge(va: 12, vb: 19, tl: 32, tr: 30),
      Edge(va: 13, vb: 15, tl: 33, tr: 17),
      Edge(va: 13, vb: 17, tl: 22, tr: 35),
      Edge(va: 13, vb: 18, tl: 34, tr: 33),
      Edge(va: 13, vb: 19, tl: 35, tr: 34),
      Edge(va: 14, vb: 18, tl: 24, tr: 31),
      Edge(va: 15, vb: 18, tl: 33, tr: 26),
      Edge(va: 16, vb: 19, tl: 30, tr: 29),
      Edge(va: 17, vb: 19, tl: 28, tr: 35),
      Edge(va: 18, vb: 19, tl: 34, tr: 32)]

    mesh.addNormalsFromOriginToPositions()
    return mesh
  }


  public class func icosahedron() -> Mesh {
    // returns an icosahedron with vertex radius of 1.
    let phi: Double = (1 + sqrt(5)) * 0.5 // golden ratio.
    // each vertex is also the vertex of an axis-aligned golden rectangle.
    // compute the radius and normalize major and minor lengths.
    let r = sqrt(phi * phi + 1)
    let m = phi / r // major.
    let n = 1.0 / r // minor.
    let mesh = Mesh(name: "icosahedron")
    mesh.positions = [
      V3D(-m, -n,  0), // south.
      V3D(-m,  n,  0), // southwest.
      V3D(-n,  0, -m),
      V3D(-n,  0,  m),
      V3D( 0, -m, -n),
      V3D( 0, -m,  n),
      V3D( 0,  m, -n), // northern hemisphere.
      V3D( 0,  m,  n),
      V3D( n,  0, -m),
      V3D( n,  0,  m),
      V3D( m, -n,  0), // northeast.
      V3D( m,  n,  0)] // north.

    mesh.triangles = [
      Tri(0,  1,  2),
      Tri(0,  2,  4),
      Tri(0,  3,  1),
      Tri(0,  4,  5),
      Tri(0,  5,  3),
      Tri(1,  3,  7),
      Tri(1,  6,  2),
      Tri(1,  7,  6),
      Tri(2,  6,  8),
      Tri(2,  8,  4),
      Tri(3,  5,  9), // index 10.
      Tri(3,  9,  7),
      Tri(4,  8, 10),
      Tri(4, 10,  5),
      Tri(5, 10,  9),
      Tri(6,  7, 11),
      Tri(6, 11,  8),
      Tri(7,  9, 11),
      Tri(8, 11, 10),
      Tri(9, 10, 11)]

    mesh.edges = [
      Edge(va: 0, vb: 1, tl: 0, tr: 2),
      Edge(va: 0, vb: 2, tl: 1, tr: 0),
      Edge(va: 0, vb: 3, tl: 2, tr: 4),
      Edge(va: 0, vb: 4, tl: 3, tr: 1),
      Edge(va: 0, vb: 5, tl: 4, tr: 3),
      Edge(va: 1, vb: 2, tl: 0, tr: 6),
      Edge(va: 1, vb: 3, tl: 5, tr: 2),
      Edge(va: 1, vb: 6, tl: 6, tr: 7),
      Edge(va: 1, vb: 7, tl: 7, tr: 5),
      Edge(va: 2, vb: 4, tl: 1, tr: 9),
      Edge(va: 2, vb: 6, tl: 8, tr: 6),
      Edge(va: 2, vb: 8, tl: 9, tr: 8),
      Edge(va: 3, vb: 5, tl: 10, tr: 4),
      Edge(va: 3, vb: 7, tl: 5, tr: 11),
      Edge(va: 3, vb: 9, tl: 11, tr: 10),
      Edge(va: 4, vb: 5, tl: 3, tr: 13),
      Edge(va: 4, vb: 8, tl: 12, tr: 9),
      Edge(va: 4, vb: 10, tl: 13, tr: 12),
      Edge(va: 5, vb: 9, tl: 10, tr: 14),
      Edge(va: 5, vb: 10, tl: 14, tr: 13),
      Edge(va: 6, vb: 7, tl: 15, tr: 7),
      Edge(va: 6, vb: 8, tl: 8, tr: 16),
      Edge(va: 6, vb: 11, tl: 16, tr: 15),
      Edge(va: 7, vb: 9, tl: 17, tr: 11),
      Edge(va: 7, vb: 11, tl: 15, tr: 17),
      Edge(va: 8, vb: 10, tl: 12, tr: 18),
      Edge(va: 8, vb: 11, tl: 18, tr: 16),
      Edge(va: 9, vb: 10, tl: 19, tr: 14),
      Edge(va: 9, vb: 11, tl: 17, tr: 19),
      Edge(va: 10, vb: 11, tl: 19, tr: 18)]

    mesh.addSegmentsFromEdges()
    mesh.addNormalsFromOriginToPositions()
    return mesh
  }
}
