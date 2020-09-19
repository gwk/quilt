// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import Quilt
import QuiltArea
import QuiltArithmetic
import QuiltVec


public enum GeomKind {
  case point(size: Float = 1.0, minSSRad: Float = 0.1, maxSSRad: Float = 1000.0)
  case seg
  case tri
}


public class Mesh {
  public var name: String? = nil
  public var positions: [V3D] = []
  public var normals: [V3F] = []
  public var colors: [V4F] = []
  public var textures: [[V2F]] = []
  #if false // TODO: implement creases.
  public var vertexCreases: [F32] = []
  public var edgeCreases: [F32] = []
  #endif
  #if false // TODO: implement BoneIndices.
  public var boneWeights: [V4F] = []
  public var boneIndices: [BoneIndices] = []
  #endif

  public var points: [Int] = []
  public var segments: [Seg] = []
  public var triangles: [Tri] = []
  public var edges: [Edge] = []

  public init(name: String? = nil) {
    self.name = name
  }

  var vertexCount: Int { positions.count }


  public func validate() {
    let vc = positions.count
    precondition(normals.isEmpty || normals.count == vc)
    precondition(colors.isEmpty || colors.count == vc)
    for t in textures {
      precondition(t.isEmpty || t.count == vc)
    }
    for s in segments {
      s.validate(vertexCount: vc)
    }

    var triHalfEdges = [HalfEdge:Int]()
    for (ti, t) in triangles.enumerated() {
      t.validate(vertexCount: vc)
      for he in t.halfEdges {
        precondition(!triHalfEdges.contains(key: he))
        triHalfEdges[he] = ti
      }
    }
    var edgeHalfEdges = [HalfEdge:Int]()
    for (ei, e) in edges.enumerated() {
      e.validate(vertexCount: vc, triangleCount: triangles.count)
      for he in e.halfEdges {
        precondition(triHalfEdges.contains(key: he))
        precondition(!edgeHalfEdges.contains(key: he))
        edgeHalfEdges[he] = ei
      }
    }
    for (he, t) in triHalfEdges {
      precondition(edgeHalfEdges.contains(key: he), "missing edge for triangle: \(t)")
    }
  }


  public func addNormalsFromOriginToPositions() {
    assert(normals.isEmpty)
    for pos in positions {
      normals.append(pos.norm.vf)
    }
  }


  public func addColorsFromPositions() {
    assert(colors.isEmpty)
    for pos in positions {
      let color3 = (pos.vf * 0.5 + 0.5).clampToUnit
      colors.append(V4F(color3, w: 1))
    }
  }


  public func addColorsFromTexCoords(channel: Int = 0) {
    assert(colors.isEmpty)
    for tex in textures[channel] {
      colors.append(V4F(tex.x, tex.y, tex.x, 1))
    }
  }


  public func addAllPoints() {
    points.append(contentsOf: 0..<positions.count)
  }

  public func addPoint(_ i: Int) {
    points.append(i)
  }

  public func addSeg(_ a: Int, _ b: Int) {
    segments.append(Seg(a, b))
  }

  public func addSeg(_ a: V3D, _ b: V3D) { // TODO: rename?
    let i = positions.count
    positions.append(a)
    positions.append(b)
    addSeg(i, i + 1)
  }

  public func addTri(_ a: Int, _ b: Int, _ c: Int) {
    triangles.append(Tri(a, b, c))
  }

  public func addQuad(_ a: V3D, _ b: V3D, _ c: V3D, _ d: V3D) { // TODO: rename?
    let i = positions.count
    positions.append(a)
    positions.append(b)
    positions.append(c)
    positions.append(d)
    addTri(i, i + 1, i + 2)
    addTri(i, i + 2, i + 3)
  }


  public func addSegmentsFromEdges() {
    for e in edges {
      if e.va < e.vb {
        segments.append(Seg(e.va, e.vb))
      }
    }
  }


  public func addAllSegments() {
    for i in 0..<positions.count {
      for j in (i + 1)..<positions.count {
        segments.append(Seg(i, j))
      }
    }
  }

  public func addAllSegmentsLessThan(length: F64) {
    for (i, a) in positions.enumerated() {
      for j in (i + 1)..<positions.count {
        let b = positions[j]
        let d = a.dist(b)
        if d > 0 && d < F64(length) {
          segments.append(Seg(i, j))
        }
      }
    }
  }

  public func addTrianglesFromSegments() {
    for (i, s) in segments.enumerated() {
      for j in (i + 1)..<segments.count {
        let t = segments[j]
        assert(s.a < t.a || (s.a == t.a && s.b < t.b))
        for k in (j + 1)..<segments.count {
          let u = segments[k]
          assert(t.a < u.a || (t.a == u.a && t.b < u.b))
          // TODO: skip non-matching s and t here.
          if s.a == t.a && s.b == u.a && t.b == u.b {
            let a = s.a
            let b = s.b
            let c = t.b
            var tri = Tri(a, b, c)
            let va = positions[a]
            let vb = positions[b]
            let vc = positions[c]
            let center = (va + vb + vc) / 3
            let edge0 = vb - va
            let edge1 = vc - va
            let normal = edge0.cross(edge1)
            if center.dot(normal) < 0 {
              tri = tri.swizzled
            }
            triangles.append(tri)
          }
        }
      }
    }
  }


  public func faceNormal(tri: Tri) -> V3D {
    (positions[tri.a] + positions[tri.b] + positions[tri.c]).norm
  }


  public func subdivide() -> Mesh {
    // Subdivide each triangle face into four subtriangles.
    // The original vertices remain at their indices.
    // For each original edge, a new midpoint vertex is added at vi = (vertexCount + origSegmentIndex).
    // For each original triangle index ti, the new corner triangles are indexed (ti*4 + 0..<3).
    // The new center triangle follows at (ti*4 + 3).
    // Three new edges are added, for each side of the new center triangle, indexed at ti*3 + 0..<2.
    // Each original edge gets split in two, indexed at tc*3 + ei*2 + 0..<1.

    assert(!positions.isEmpty)
    assert(!triangles.isEmpty)
    assert(!edges.isEmpty)

    let subdiv = Mesh(name: self.name)
    subdiv.triangles = Array(repeating: .invalid, count: triangles.count * 4)
    subdiv.positions = positions // Copy existing vertices.
    subdiv.textures = textures

    // Generate new edges for center triangles first.
    for (ti, _) in triangles.enumerated() {
      for i in 0..<3 {
        subdiv.triangles[ti*4+i][i] = triangles[ti][i] // One corner of each corner triangle is the same as original.
        subdiv.edges.append(Edge(va: -2, vb: -1, tl: ti*4+3, tr: ti*4+i))
        // Create new edges, indexed around center triangle in order, so that we can fill them later.
        // At this point they are all the same; order meaning is determined below.
      }
    }

    // Generate new vertices and edges; fill in triangles gradually as we visit the edges.
    for edge in edges {
      let iva = edge.va
      let ivb = edge.vb
      let itl = edge.tl
      let itr = edge.tr
      let va = positions[iva]
      let vb = positions[ivb]

      // Create midpoint vertex.
      let ivm = subdiv.positions.count
      subdiv.positions.append(va.mid(vb))

      // Matching texture coordinates.
      for channel in 0..<textures.count {
        let texA = textures[channel][iva]
        let texB = textures[channel][ivb]
        subdiv.textures[channel].append(texA.mid(texB))
      }

      let tl = triangles[itl]
      // Intra-triangle vertex indices.
      let tl_ia: Int = tl.triVertexIndex(meshVertexIndex: iva)
      let tl_ib = (tl_ia+1) % 3
      let tl_ic = (tl_ia+2) % 3
      assert(tl.triVertexIndex(meshVertexIndex: ivb) == tl_ib)
      // Subdivided triangle indices, which are ordered by original triangle vertex order.
      let tla = itl*4 + tl_ia
      let tlb = itl*4 + tl_ib
      // Center triangle edge indices.
      let ela = itl*3 + tl_ia
      let elb = itl*3 + tl_ib

      // Find right-side indices if `tr` is set on original.
      let tr_ia, tr_ib, tr_ic, tra, trb, era, erb: Int
      if itr >= 0 {
        let tr = triangles[itr]
        tr_ia = tr.triVertexIndex(meshVertexIndex: iva)
        tr_ib = (tr_ia+2) % 3 // +2 for reversed winding.
        tr_ic = (tr_ia+1) % 3 // +1 for reversed winding.
        assert(tr.triVertexIndex(meshVertexIndex: ivb) == tr_ib)
        tra = itr*4 + tr_ia
        trb = itr*4 + tr_ib
        era = itr*3 + tr_ia
        erb = itr*3 + tr_ib
      } else {
        tr_ia = -1
        tr_ib = -1
        tr_ic = -1
        tra = -1
        trb = -1
        era = -1
        erb = -1
      }
      let ea = Edge(va: iva, vb: ivm, tl: tla, tr: tra)
      let eb = Edge(va: ivm, vb: ivb, tl: tlb, tr: trb)
      subdiv.edges.append(ea)
      subdiv.edges.append(eb)

      // Fill in referenced triangles and edges.

      assertNegOrEq(subdiv.triangles[tla][tl_ia], ea.va)
      assertNegOrEq(subdiv.triangles[tla][tl_ib], ea.vb)
      assertNegOrEq(subdiv.triangles[tlb][tl_ia], eb.va)
      assertNegOrEq(subdiv.triangles[tlb][tl_ib], eb.vb)
      assert(subdiv.triangles[itl*4 + 3][tl_ic] < 0)

      subdiv.triangles[tla][tl_ia] = ea.va
      subdiv.triangles[tla][tl_ib] = ea.vb
      subdiv.triangles[tlb][tl_ia] = eb.va
      subdiv.triangles[tlb][tl_ib] = eb.vb
      subdiv.triangles[itl*4 + 3][tl_ic] = ivm

      assert(subdiv.edges[ela].vb == -1, "\(subdiv.edges[ela])")
      assert(subdiv.edges[elb].va == -2, "\(subdiv.edges[elb])")
      subdiv.edges[ela].vb = ivm
      subdiv.edges[elb].va = ivm

      if itr >= 0 {
        assertNegOrEq(subdiv.triangles[tra][tr_ia], ea.va)
        assertNegOrEq(subdiv.triangles[tra][tr_ib], ea.vb)
        assertNegOrEq(subdiv.triangles[trb][tr_ia], eb.va)
        assertNegOrEq(subdiv.triangles[trb][tr_ib], eb.vb)
        assert(subdiv.triangles[itr*4 + 3][tr_ic] < 0)

        subdiv.triangles[tra][tr_ia] = ea.va
        subdiv.triangles[tra][tr_ib] = ea.vb
        subdiv.triangles[trb][tr_ia] = eb.va
        subdiv.triangles[trb][tr_ib] = eb.vb
        subdiv.triangles[itr*4 + 3][tr_ic] = ivm

        assert(subdiv.edges[era].va == -2)
        assert(subdiv.edges[erb].vb == -1)
        subdiv.edges[era].va = ivm
        subdiv.edges[erb].vb = ivm
      }
    }

    for i in 0..<subdiv.triangles.count {
      subdiv.triangles[i].rotateIndicesToCanonical()
    }
    subdiv.validate()
    return subdiv
  }


  public func subdivide(steps: Int) -> Mesh {
    var m = self
    for _ in 0..<steps {
      m = m.subdivide()
    }
    return m
  }


  public func subdivideToSphere(steps: Int = 1) -> Mesh {
    let mesh = subdivide(steps: steps)
    mesh.positions = mesh.positions.map { $0.norm }
    if !self.normals.isEmpty && mesh.normals.isEmpty {
      mesh.addNormalsFromOriginToPositions()
    }
    return mesh
  }


  public func rangesFor(triangleGrid: Range<Int>, texSize: V2I) -> (ClosedRange<Int>, ClosedRange<Int>) {

    func validatedTexCoordRange(indices: Set<Int>, axis: Int, size: Int) -> ClosedRange<Int> {
      let els = Set(indices.map { self.textures[0][$0][axis] }).sorted()
      let scale = F32(size)
      let intEls = els.map { ($0 * scale).asRoundedInt }
      let r = intEls.closedRange()!
      assert(intEls == Array(r))
      return r
    }

    let indices = Set(triangleGrid.flatMap { triangles[$0].vertexIndices })
    let rtx = validatedTexCoordRange(indices: indices, axis: 0, size: texSize.x)
    let rty = validatedTexCoordRange(indices: indices, axis: 1, size: texSize.y)
    print(rtx, rty)
    return (rtx, rty)
  }


  public func fillTritexture(triangleGrid: Range<Int>, src: AreaArray<V4U8>, dst: AreaArray<V4U8>) {

    // Convert to lon/lat and sample from the mercator image.
    func sampleMercator(_ p0: V3D, _ p1: V3D, _ p2: V3D) -> V4U8 {
      let p = (p0 + p1 + p2) / 3.0 // For now, just sample centroid. We should iterate over all source pixels and average.
      let xz = (p.x.sqr + p.z.sqr).sqrt
      let lon = atan2(p.x, p.z)
      let lat = atan2(p.y, xz)
      let ulon = lon/(2*F64.pi) + 0.5
      let ulat = -lat/F64.pi + 0.5
      let samplePos = V2I(V2D(F64(ulon), F64(ulat)) * V2D(src.size))
      return src.el(samplePos)
    }

    let tritexDoubleX = 2
    let w = (dst.size.x / tritexDoubleX).asF64
    let h = dst.size.y.asF64
    for var tri in triangles[triangleGrid] {
      tri.rotateIndicesToMinVertex(vertices: textures[0]) // A becomes the lowest index by texture U,V.
      typealias PT = (p:V3D, t:V2F) // Position, Texture0.
      let a: PT = (positions[tri.a], textures[0][tri.a])
      let b: PT = (positions[tri.b], textures[0][tri.b])
      let c: PT = (positions[tri.c], textures[0][tri.c])
      // Assuming a top-down texture V axis, and only two right triangle orientations `left` and `right`: slope is always -1.
      // Left: | a-c | Right: |  /b |
      //       | b/  |        | a-c |
      // Call the vertex at the right angle corner `medial`, and the other at the same horizontal V value `distal`. The remaining vertex is `tip`.
      let isLeft = (a.t.x == b.t.x)
      let tip, medial, distal: PT // Base vertices.
      if isLeft { // Top/low/left triangle.
        assert(a.t.x < c.t.x)
        assert(a.t.y < b.t.y)
        tip = b
        medial = a
        distal = c
      } else { // Bottom/high/right triangle.
        assert(a.t.x < b.t.x)
        assert(b.t.y > c.t.y)
        tip = c
        medial = b
        distal = a
      }
      assert(medial.t.x == tip.t.x)
      assert(medial.t.y == distal.t.y)

      let kl = isLeft ? 0 : 1
      let kr = isLeft ? 1 : 0
      // Iterate over the V axis from tip to base, using scaled up tex coords that we can round to int steps.
      let tipV = tip.t.y.asF64 * h
      let baseV = medial.t.y.asF64 * h
      let deltaV = baseV - tipV // Delta. This is negative for left triangles.
      let dstOffV = (deltaV > 0) ? -1 : 0
      let nextV = tipV + deltaV.signedUnit // Step towards base.
      var row0: [V3D] = [tip.p]

      for v in signedClosedRange(nextV.asRoundedInt, baseV.asRoundedInt) {
        let t = (v.asF64 - tipV) / deltaV // Interpolation fraction from tip to base, for pixel `y` top edge.
        // Interpolate across the V axis to get medial and distal vertices.
        let row_medial: PT = (p: tip.p.lerp(medial.p, t), t: tip.t.lerp(medial.t, t))
        let row_distal: PT = (p: tip.p.lerp(distal.p, t), t: tip.t.lerp(distal.t, t))
        let medialU = row_medial.t.x.asF64 * w
        let distalU = row_distal.t.x.asF64 * w
        let deltaU = distalU - medialU
        let dstOffU = (deltaU > 0) ? -1 : 0
        let nextU = medialU + deltaU.signedUnit
        var row1: [V3D] = [row_medial.p]

        for (i, u) in signedClosedRange(nextU.asRoundedInt, distalU.asRoundedInt).enumerated() {
          let dstU = (u+dstOffU) * tritexDoubleX
          let dstV = v+dstOffV
          let p0M = row0[i]
          let p1M = row1.last!
          let s = (u.asF64 - medialU) / deltaU // Interpolation fraction from medial to distal, for pixel `x` right edge.
          let p1D = row_medial.p.lerp(row_distal.p, s)
          row1.append(p1D)
          let sampleL = sampleMercator(p0M, p1M, p1D)
          assert(dst.el(V2I(dstU+kl, dstV)).w == 0x00)
          dst.setEl(V2I(dstU+kl, dstV), sampleL)
          let j = i + 1
          if j < row0.count { // Also sample right tritexel.
            let p0D = row0[j]
            let sampleR = sampleMercator(p0M, p0D, p1D)
            assert(dst.el(V2I(dstU+kr, dstV)).w == 0x00)
            dst.setEl(V2I(dstU+kr, dstV), sampleR)
          }
        }
        row0 = row1
      }
    }
  }
}



func assertNegOrEq(_ index: Int, _ expected: Int) {
  assert(index < 0 || index == expected)
}
