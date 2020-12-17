// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import QuiltArithmetic
import QuiltVec
import GameKit


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

  public class func terrain(width: Double, cells: Int, dir: Int, origin: V3D, height: Double, noiseMap: GKNoiseMap) -> Mesh {
    let m = Mesh(name: "terrain")
    if cells == 0 {
      return m
    }

    var tempPos = [[V3D]](repeating: [V3D](repeating: .zero, count: cells + 1), count: cells + 1) // Empty vertex position 2d array.

    let sideLength = width/Double(cells)
    let halfWidth = width/Double(2)
    let hScale = height/2
    let vertexPerSide = cells + 1

    for j in 0..<tempPos.count {
      for i in 0..<tempPos[j].count {
        let noisePos = vector2(Int32(i), Int32(j))
        let sample = Double(noiseMap.value(at: noisePos))
        tempPos[j][i] = origin + V3D(
                  -halfWidth + sideLength * Double(i),
                  sample * hScale,
                  -halfWidth + sideLength * Double(j))
        m.positions.append(tempPos[j][i])
      }
    }

    for j in 0..<(tempPos.count - 1) {
      for i in 0..<(tempPos[j].count) - 1 {
        let v0 = j*(vertexPerSide) + i
        let v1 = j*(vertexPerSide) + i + 1
        let v2 = (j+1)*(vertexPerSide) + i
        let v3 = (j+1)*(vertexPerSide) + i + 1

        m.triangles.append(Tri(v0, v2, v1))
        m.triangles.append(Tri(v1, v2, v3))
      }
    }

    for j in 0..<tempPos.count - 1 {
      for i in 0..<tempPos[j].count {
        if i % cells != 0 || i == 0 {
          let v0 = (j * cells) + i + j
          let v1 = v0 + 1
          let v2 = v0 + vertexPerSide
          let v3 = v2 + 1
          let cell = v0 - j
          let tri0 = cell * 2
          let tri1 = tri0 + 1
          m.edges.append(Edge(va: v2, vb: v1, tl: tri0, tr: tri1)) // always with these two triangles independent of surrounding triangles
          // Left edge : different when on left edge / when the v0 % (cells + 1) == 0
          if v0 % (vertexPerSide) == 0 { // On edge
            m.edges.append(Edge(va: v0, vb: v2, tl: tri0, tr: -1))
          } else { // Not on edge
            let tri3 = tri0 - 1
            m.edges.append(Edge(va: v0, vb: v2, tl: tri0, tr: tri3))
          }
          // Bottom edge : different when in last row
          if j == cells - 1 {
            m.edges.append(Edge(va: v2, vb: v3, tl: tri1, tr: -1))
          } else {
            let tri4 = tri0 + (cells * 2)
            m.edges.append(Edge(va: v2, vb: v3, tl: tri1, tr: tri4))
          }
        }
      }
    }

    // Right side:
    for i in 1...cells {
      let v0 = i * (vertexPerSide) - 1
      let v1 = v0 + vertexPerSide
      let tri = (i * (cells * 2)) - 1
      m.edges.append(Edge(va: v1, vb: v0, tl: tri, tr: -1))
    }

    // Top
    var tempCount = 1
    for i in 0...(cells - 1) {
      let v0 = i
      let v1 = v0 + 1
      let tri = 2 * i
      tempCount += 1
      m.edges.append(Edge(va: v1, vb: v0, tl: tri, tr: -1))
    }

    m.segments = []

    m.validate()
    return m
  }
}
