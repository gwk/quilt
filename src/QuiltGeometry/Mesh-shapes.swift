// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import QuiltArea
import QuiltArithmetic
import QuiltVec


extension Mesh {

  public class func triangle() -> Mesh {
    // One-sided triangle in the XY plane, with vertex radius of 1.
    let x: Double = sqrt(3.0) * 0.5
    let m = Mesh(name: "triangle")

    m.positions = [
      V3D(0, -1, 0),
      V3D( x, 0.5, 0),
      V3D(-x, 0.5, 0)]

    m.triangles = [Tri(0, 1, 2)]

    m.segments = [
      Seg(0, 1),
      Seg(0, 2),
      Seg(1, 2)]

    m.edges = [
      Edge(va: 0, vb: 1, tl: 0, tr: -1),
      Edge(va: 1, vb: 2, tl: 0, tr: -1),
      Edge(va: 2, vb: 0, tl: 0, tr: -1)]

    return m
  }


  public class func triangleXZ(sideLength: F64 = 1) -> Mesh {
    // Looks like:
    // *-----*
    //  \ +-/--+X
    //   \|/
    //    *
    //    +z

    let m = Mesh(name: "triangleXZ")

    let x = sideLength * 0.5
    let zLengthThird = x * sqrt(3.0) / 3.0
    let zLow = -zLengthThird
    let zHigh = zLengthThird * 2

    m.positions = [
      V3D(-x, 0, zLow),
      V3D( 0, 0, zHigh),
      V3D( x, 0, zLow)]

    m.triangles = [Tri(0, 1, 2)]

    m.edges = [
      Edge(va: 0, vb: 1, tl: 0, tr: -1),
      Edge(va: 1, vb: 2, tl: 0, tr: -1),
      Edge(va: 2, vb: 0, tl: 0, tr: -1)]

    m.validate()

    return m
  }


  public class func quad() -> Mesh {
    // Square in the XY plane, with side length 2.
    let m = Mesh(name: "quad")

    m.positions = [
      V3D(-1, -1, 0),
      V3D(-1,  1, 0),
      V3D( 1, -1, 0),
      V3D( 1,  1, 0)]

    m.triangles = [
      Tri(0, 2, 1),
      Tri(1, 2, 3)]

    m.segments = []

    m.edges = [
      Edge(va: 0, vb: 2, tl: 0, tr: -1),
      Edge(va: 2, vb: 3, tl: 1, tr: -1),
      Edge(va: 3, vb: 1, tl: 1, tr: -1),
      Edge(va: 1, vb: 0, tl: 0, tr: -1),
      Edge(va: 2, vb: 1, tl: 0, tr: 1)]

    m.validate()
    return m
  }


  public class func quadXZ(sideLength: F64 = 1) -> Mesh {

    let m = Mesh(name: "quadXZ")
    let l = sideLength * 0.5
    m.positions = [
      V3D(-l, 0, -l),
      V3D(-l, 0,  l),
      V3D( l, 0, -l),
      V3D( l, 0,  l)]

    m.triangles = [
      Tri(0, 2, 1),
      Tri(1, 2, 3)]

    m.segments = []

    m.edges = [
      Edge(va: 0, vb: 2, tl: 0, tr: -1),
      Edge(va: 2, vb: 3, tl: 1, tr: -1),
      Edge(va: 3, vb: 1, tl: 1, tr: -1),
      Edge(va: 1, vb: 0, tl: 0, tr: -1),
      Edge(va: 2, vb: 1, tl: 0, tr: 1)]

    m.validate()
    return m
  }


  public class func squareSheetXZ(sideSegmentCount: Int, sideLength: F64 = 1, addCrossPoints: Bool) -> Mesh {

    let m = Mesh(name: addCrossPoints ? "squareCrossTerrain" : "squareDiagonalTerrain")
    if sideSegmentCount < 1 { return m }

    let sideVertexCount = sideSegmentCount + 1
    let grid = ColArray<V3D>(size: V2I(sideVertexCount, sideVertexCount), val: .zero)

    // Calculate grid positions.
    let sscf = F64(sideSegmentCount)
    for c in grid.coordsByCol() {
      let pos2 = (c.vd / sscf - 0.5) * sideLength
      let pos = V3D(pos2.x, 0, pos2.y)
      grid.setEl(c, pos)
    }

    // Cross pattern has 4 triangles and 6 edges for every cell, plus 2 edges that belong to the next cell:
    //     ←e1
    //    *-----*
    //    |\ t1/
    //    | \ /
    // e0 |t0* t3
    // ↓  | / \
    //    |/ t2\
    //    *     *

    // Diagonal pattern has 2 triangles and 3 edges for every cell, plus 2 edges that belong to the next cell:
    //     ←e1
    //    *---*
    //    |t0/
    // e0 | /
    // ↓  |/t1
    //    *   *

    let quadCount = grid.quadCount

    if addCrossPoints { // We will append the extra middle vertices directly into the grid array, without resizing the grid.
      grid.array.reserveCapacity(grid.count + quadCount)
    }

    let trisPerQuad = (addCrossPoints ? 4 : 2)
    let trisPerCol = trisPerQuad * grid.quadsPerCol
    let edgesPerQuad = (addCrossPoints ? 6 : 3) // The "tiling" edges that can be indexed by the grid: low edges and internal edges.
    let edgeCount = quadCount * edgesPerQuad + sideSegmentCount * 2 // The tiling edges plus the right and bottom edges.

    m.triangles = Array(repeating: .invalid, count: quadCount * trisPerQuad)

    // Prefill the array with edges. The first `edgesPerQuad` block are indexed per quad.
    // The next `sideSegment` edges are the right edge.
    // The last `sideSegment` edges are the bottom edge.
    m.edges = Array(repeating: .invalid, count: edgeCount)

    for (qi, (ll, lh, hl, hh)) in grid.indexQuadsByCol().enumerated() {
      // Vertex indices are named for XZ position: "low, low", "low, high", "high, low", "high, high".
      let ti0 = qi * trisPerQuad
      let ti1 = ti0 + 1
      let ei = qi * edgesPerQuad

      let llc = grid.coord(ll)
      let isOnLeftEdge = (llc.x == 0)
      let isOnTopEdge = (llc.y == 0)

      if addCrossPoints {
        let ti2 = ti0 + 2
        let ti3 = ti0 + 3
        let mid = (grid[ll] + grid[lh] + grid[hl] + grid[hh]) * 0.25
        let mm = grid.count
        grid.array.append(mid) // We can append to the underlying array, even though the area bounds do not change.
        m.triangles[ti0] = Tri(ll, lh, mm) // Left.
        m.triangles[ti1] = Tri(ll, mm, hl) // Top.
        m.triangles[ti2] = Tri(lh, hh, mm) // Bottom.
        m.triangles[ti3] = Tri(hl, mm, hh) // Right.
        m.edges[ei+0] = Edge(va: ll, vb: lh, tl: ti0, tr: (isOnLeftEdge ? -1 : (ti3 - trisPerCol))) // tr is ti3 of prev col.
        m.edges[ei+1] = Edge(va: hl, vb: ll, tl: ti1, tr: (isOnTopEdge ? -1 : (ti2 - trisPerQuad))) // tr ti2 of prev row.
        m.edges[ei+2] = Edge(va: mm, vb: ll, tl: ti0, tr: ti1)
        m.edges[ei+3] = Edge(va: mm, vb: lh, tl: ti2, tr: ti0)
        m.edges[ei+4] = Edge(va: mm, vb: hl, tl: ti1, tr: ti3)
        m.edges[ei+5] = Edge(va: mm, vb: hh, tl: ti3, tr: ti2)
      } else {
        m.triangles[ti0] = Tri(ll, lh, hl)
        m.triangles[ti1] = Tri(lh, hh, hl)
        m.edges[ei+0] = Edge(va: ll, vb: lh, tl: ti0, tr: (isOnLeftEdge ? -1 : (ti1 - trisPerCol))) // tr is ti1 of prev col.
        m.edges[ei+1] = Edge(va: hl, vb: ll, tl: ti0, tr: (isOnTopEdge ? -1 : (ti1 - trisPerQuad))) // tr is ti1 of prev row.
        m.edges[ei+2] = Edge(va: lh, vb: hl, tl: ti0, tr: ti1)
      }
    }


    // Fill edges on right and bottom edges of mesh.
    let leftEdgesIdx = quadCount * edgesPerQuad // The run of left edges immediately follows the main block of quad edges.
    let bttmEdgesIdx = leftEdgesIdx + sideSegmentCount // The run of bottom edges follows the run of left edges.
    let gs = grid.size
    let gl = grid.size &- 1 // "Grid last".
    let rv0 = gs.y * gl.x // The first vertex index of the rightmost column.
    let bv0 = gl.y // The first vertex index of the bottom row.
    let rt0 = trisPerCol * (gl.x - 1) + (addCrossPoints ? 3 : 1)
    let bt0 = trisPerQuad * (gl.y - 1) + (addCrossPoints ? 2 : 1)

    for i in 0..<gl.x { // Right.
      let rvi = rv0 + i
      let rvj = rvi + 1 // Next down.
      let rt = rt0 + (i * trisPerQuad)
      m.edges[leftEdgesIdx + i] = Edge(va: rvj, vb: rvi, tl: rt, tr: -1)
    }
    for i in 0..<gl.y { // Bottom.
      let bvi = bv0 + gs.y * i
      let bvj = bvi + gs.y // Next right.
      let bt = bt0 + (i * trisPerCol)
      m.edges[bttmEdgesIdx + i] = Edge(va: bvi, vb: bvj, tl: bt, tr: -1)
    }

    m.positions = grid.array // Copy the array to the mesh only when we are done modifying it. This prevents a COW copy.
    m.validate()
    return m
  }


  public class func cuboid(xs: (F64, F64), ys: (F64, F64), zs:(F64, F64)) -> Mesh {
    // Returns a rectangular cuboid.
    let mesh = Mesh(name: "cuboid")

    mesh.positions = [
      V3D(xs.0, ys.0, zs.0),
      V3D(xs.0, ys.0, zs.1),
      V3D(xs.0, ys.1, zs.0),
      V3D(xs.0, ys.1, zs.1),
      V3D(xs.1, ys.0, zs.0),
      V3D(xs.1, ys.0, zs.1),
      V3D(xs.1, ys.1, zs.0),
      V3D(xs.1, ys.1, zs.1)]

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
}
