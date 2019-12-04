// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import SceneKit
import Quilt
import QuiltUI
import QuiltSceneKit


enum GeomKind {
  case point(size: CGFloat = 1.0, minSSRad: CGFloat = 0.1, maxSSRad: CGFloat = 1000.0)
  case seg
  case tri
}

class Mesh {
  var name: String? = nil
  var positions: [V3] = []
  var normals: [V3] = []
  var colors: [V4] = []
  var textures: [[V2]] = []
  #if false // TODO: implement creases.
  var vertexCreases: [F32] = []
  var edgeCreases: [F32] = []
  #endif
  #if false // TODO: implement BoneIndices.
  var boneWeights: [V4] = []
  var boneIndices: [BoneIndices] = []
  #endif

  var points: [Int] = []
  var segments: [Seg] = []
  var triangles: [Tri] = []
  var adjacencies: [Adj] = []

  init(name: String? = nil) {
    self.name = name
  }

  var vertexCount: Int { return positions.count }

  func validate() {
    let vc = positions.count
    precondition(normals.isEmpty || normals.count == vc)
    precondition(colors.isEmpty || colors.count == vc)
    for t in textures {
      precondition(t.isEmpty || t.count == vc)
    }
    for s in segments {
      s.validate(vertexCount: vc)
    }
    for t in triangles {
      t.validate(vertexCount: vc)
    }
    for a in adjacencies {
      a.validate(triangleCount: triangles.count)
    }
  }

  func addNormalsFromOriginToPositions() {
    assert(normals.isEmpty)
    for pos in positions {
      normals.append(pos.norm)
    }
  }

  func addColorsFromPositions() {
    assert(colors.isEmpty)
    for pos in positions {
      let color3 = (pos * 0.5 + 0.5).clampToUnit
      colors.append(V4(color3, w: 1))
    }
  }

  func addColorsFromTextures(channel: Int = 0) {
    assert(colors.isEmpty)
    for tex in textures[channel] {
      colors.append(V4(tex.x, tex.y, 0, 1))
    }
  }


  func addAllPoints() {
    points.append(contentsOf: 0..<positions.count)
  }

  func addPoint(_ i: Int) {
    points.append(i)
  }

  func addSeg(_ a: Int, _ b: Int) {
    segments.append(Seg(a, b))
  }

  func addSeg(_ a: V3, _ b: V3) { // TODO: rename?
    let i = positions.count
    positions.append(a)
    positions.append(b)
    addSeg(i, i + 1)
  }

  func addTri(_ a: Int, _ b: Int, _ c: Int) {
    triangles.append(Tri(a, b, c))
  }

  func addQuad(_ a: V3, _ b: V3, _ c: V3, _ d: V3) { // TODO: rename?
    let i = positions.count
    positions.append(a)
    positions.append(b)
    positions.append(c)
    positions.append(d)
    addTri(i, i + 1, i + 2)
    addTri(i, i + 2, i + 3)
  }


  func addSegmentsFromAdjacencies() {
    for a in adjacencies {
      let t0 = triangles[a.a]
      let t1 = triangles[a.b]
      segments.append(t0.commonEdge(t1))
    }
  }

  func addAllSegments() {
    for i in 0..<positions.count {
      for j in (i + 1)..<positions.count {
        segments.append(Seg(i, j))
      }
    }
  }

  func addAllSegmentsLessThan(length: Flt) {
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

  func addTrianglesFromSegments() {
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


  func faceNormal(tri: Tri) -> V3 {
    return (positions[tri.a] + positions[tri.b] + positions[tri.c]).norm
  }


  func geometry(kinds: [GeomKind] = [.tri]) -> SCNGeometry {

    let len = positions.count

    // data offsets.
    let op = 0 // position data is required.
    var on = 0
    var oc = 0
    var ots: [Int] = []
    #if false // TODO: creases.
      var ovc = 0
      var oec = 0
    #endif
    #if false // TODO: bones.
      var obw = 0
    var obi = 0
    #endif

    var stride = MemoryLayout<V3S>.size // always have positions.
    if !normals.isEmpty {
      assert(normals.count == len)
      on = stride
      stride += MemoryLayout<V3S>.size
    }
    if !colors.isEmpty {
      assert(colors.count == len)
      oc = stride
      stride += MemoryLayout<V4S>.size
    }
    for texCoords in textures {
      if !texCoords.isEmpty {
        assert(texCoords.count == len)
        ots.append(stride)
        stride += MemoryLayout<V2S>.size
      }
    }
    #if false // TODO: creases.
    if !vertexCreases.isEmpty {
      assert(vertexCreases.count == len)
      ovc = stride
      stride += MemoryLayout<F32>.size
    }
    if !edgeCreases.isEmpty {
      assert(edgeCreases.count == len)
      oec = stride
      stride += MemoryLayout<F32>.size
    }
    #endif
    #if false // TODO: bones.
      if !bw.isEmpty {
        assert(boneWeights.count == len)
        obw = stride
        stride += MemoryLayout<V4>.size
      }
      if !bi.isEmpty {
        assert(boneIndices.count == len)
        obi = stride
        stride += MemoryLayout<BoneIndices>.size
      }
    #endif

    // Generate interleaved data.
    let d = NSMutableData(capacity: len * stride)!
    for i in 0..<len {
      d.append(positions[i].vs)
      if !normals.isEmpty         { d.append(normals[i].vs) }
      if !colors.isEmpty          { d.append(colors[i].vs) }
      for texCoords in textures {
        if !texCoords.isEmpty       { d.append(texCoords[i].vs) }
      }
      #if false // TODO: creases.
        if !vertexCreases.isEmpty   { d.append(vertexCreases[i]) }
        if !edgeCreases.isEmpty     { d.append(edgeCreases[i]) }
      #endif
      #if false // TODO: bones.
        if !bw.isEmpty  { d.append(bw[i]) }
        if !bi.isEmpty  { d.append(bi[i]) }
      #endif
    }

    var sources: [SCNGeometrySource] = []

    sources.append(SCNGeometrySource(
      data: d as Data,
      semantic: SCNGeometrySource.Semantic.vertex,
      vectorCount: len,
      usesFloatComponents: true,
      componentsPerVector: 3,
      bytesPerComponent: MemoryLayout<F32>.size,
      dataOffset: op,
      dataStride: stride))

    if !normals.isEmpty {
      sources.append(SCNGeometrySource(
        data: d as Data,
        semantic: SCNGeometrySource.Semantic.normal,
        vectorCount: len,
        usesFloatComponents: true,
        componentsPerVector: 3,
        bytesPerComponent: MemoryLayout<F32>.size,
        dataOffset: on,
        dataStride: stride))
    }
    if !colors.isEmpty {
      sources.append(SCNGeometrySource(
        data: d as Data,
        semantic: SCNGeometrySource.Semantic.color,
        vectorCount: len,
        usesFloatComponents: true,
        componentsPerVector: 4,
        bytesPerComponent: MemoryLayout<F32>.size,
        dataOffset: oc,
        dataStride: stride))
    }
    for (ot, texCoords) in zip(ots, textures) {
      if !texCoords.isEmpty {
        sources.append(SCNGeometrySource(
          data: d as Data,
          semantic: SCNGeometrySource.Semantic.texcoord,
          vectorCount: len,
          usesFloatComponents: true,
          componentsPerVector: 2,
          bytesPerComponent: MemoryLayout<F32>.size,
          dataOffset: ot,
          dataStride: stride))
      }
    }

    var elements: [SCNGeometryElement] = []
    for kind in kinds {
      let element: SCNGeometryElement
      switch kind {
      case .point(let size, let minRad, let maxRad):
        element = SCNGeometryElement(indices: points, vertexCount: positions.count, primitiveType: .point)
        element.pointSize = size
        element.minimumPointScreenSpaceRadius = minRad
        element.maximumPointScreenSpaceRadius = maxRad
      case .seg:
        element = segments.withBufferRebound(to: Int.self) {
          SCNGeometryElement(indices: $0, vertexCount: positions.count, primitiveType: .line)
        }
      case .tri:
        element = triangles.withBufferRebound(to: Int.self) {
          SCNGeometryElement(indices: $0, vertexCount: positions.count, primitiveType: .triangles)
        }
      }
      elements.append(element)
    }
    let geometry = SCNGeometry(sources: sources, elements: elements)
    geometry.name = name
    return geometry
  }


  func subdivide() -> Mesh {
    // Subdivide each triangle face into four subtriangles.
    // This requires splitting each edge in half.
    assert(!positions.isEmpty)
    assert(!triangles.isEmpty)
    assert(!adjacencies.isEmpty)
    assert(!segments.isEmpty)

    let s = Mesh()
    s.positions = positions // Copy existing vertices.
    s.normals = normals
    s.triangles = Array(repeating: .invalid, count: triangles.count * 4)

    // For each triangle, begin filling in corner subtriangles and adjacencies.
    for i in 0..<triangles.count {
      let t = triangles[i]
      let sub_ti = i * 4 // Subdivision triangles starting index.
      let center_ti = sub_ti + 3 // The new center triangle comes last.
      for q in 0..<3 {
        let corner_ti = sub_ti + q // Corner triangle index.
        // For each corner triangle, set the single existing vertex index now.
        s.triangles[corner_ti][q] = t[q] // Corner sub triangles are indexed 0 to 2.
        // Create the adjacency between corner and center triangles.
        s.adjacencies.append(Adj(corner_ti, center_ti))
      }
    }

    // All remaining data is filled in by iterating over the original segments.
    for ei in 0..<segments.count {
      let e = segments[ei]
      let a = adjacencies[ei]

      let ti0 = a.a
      let ti1 = a.b
      let sti0 = ti0 * 4
      let sti1 = ti1 * 4

      let t0 = triangles[ti0]
      let t1 = triangles[ti1]

      let ((t0q, t0r), (t1q, t1r))  = t0.commonEdgeTriangleIndices(t1)

      let vm = positions[e.a].mid(positions[e.b])
      let vmi = s.positions.count // Midpoint vertex index.
      s.positions.append(vm)
      if !normals.isEmpty {
        let nm = (normals[e.a] + normals[e.b]).norm
        s.normals.append(nm)
      }

      // center triangles touching vm.
      s.triangles[sti0+3][t0q] = vmi
      s.triangles[sti1+3][t1q] = vmi

      // corner triangles
      s.triangles[sti0+t0q][t0r] = vmi
      s.triangles[sti0+t0r][t0q] = vmi
      s.triangles[sti1+t1q][t1r] = vmi
      s.triangles[sti1+t1r][t1q] = vmi

      // adjacencies
      s.adjacencies.append(Adj(sti0 + t0q, sti1 + t1r))
      s.adjacencies.append(Adj(sti0 + t0r, sti1 + t1q))
    }

    for i in 0..<s.triangles.count {
      var t = s.triangles[i]
      t.fixIndexOrder()
      s.triangles[i] = t
    }

    s.addSegmentsFromAdjacencies()

    s.validate()
    assert(s.positions.count == positions.count + segments.count)
    assert(s.triangles.count == triangles.count * 4)
    return s
  }


  func fillVerticalTextureStrip(dst: AreaArray<V4U8>, src: AreaArray<V4U8>, triRange: Range<Int>) {
    //print(triangles[triRange])
    let w = dst.size.x.asF64
    let h = dst.size.y.asF64
    for tri in triangles[triRange] {
      // Left/right and bottom/top.
      typealias PT = (p:V3, t:V2) // Position, Texture0.
      let a: PT = (positions[tri.a], textures[0][tri.a])
      let b: PT = (positions[tri.b], textures[0][tri.b])
      let c: PT = (positions[tri.c], textures[0][tri.c])
      // For now, assume top-down globe strips.
      assert(a.p.y >= b.p.y)
      assert(a.p.y > c.p.y)
      assert(a.t.y < b.t.y)
      assert(a.t.y <= c.t.y)
      let lb: PT
      let rb: PT
      let lt: PT
      let rt: PT
      if a.t.x == b.t.x {
        lb = a
        rb = c
        lt = b
        rt = b
      } else {
        lb = a
        rb = a
        lt = b
        rt = c
      }
      //print(tri)
      //print(lb, rb)
      //print(lt, rt)
      assert(lb.t.x <= rb.t.x)
      assert(lt.t.x <= rt.t.x)
      assert(lb.t.y < lt.t.y)
      assert(rb.t.y < rt.t.y)

      // Iterate over the texture y axis from jl to jh.
      let jl = lb.t.y.asF64 * h
      let jh = lt.t.y.asF64 * h
      let jd = jh - jl // Delta; length over iterated range.
      for y in Int(round(jl))..<Int(round(jh)) { // Y is position in dst.
        let t = (y.asF64+0.5 - jl) / jd // Interpolation fraction from jl to jh, for pixel center.
        // Interpolate across the y axis to get left and right texture coords.
        let l: PT = (p: lb.p.lerp(lt.p, t), t: lb.t.lerp(lt.t, t))
        let r: PT = (p: rb.p.lerp(rt.p, t), t: rb.t.lerp(rt.t, t))
        let il = l.t.x.asF64 * w
        let ih = r.t.x.asF64 * w
        let id = ih - il
        for x in Int(round(il))..<Int(round(ih)) {
          let s = (x.asF64+0.5 - il) / id // Interpolation fraction from il to ih, for pixel center.
          let v: PT = (p: l.p.lerp(r.p, s), l.t.lerp(r.t, s))
          // Convert to lon/lat and sample from the mercator image.
          let xz = (v.p.x.sqr + v.p.z.sqr).sqrt
          let lon = atan2(v.p.x, v.p.z)
          let lat = atan2(v.p.y, xz)
          let ulon = lon/(2*Flt.pi) + 0.5
          let ulat = -lat/Flt.pi + 0.5
          let samplePos = V2I(V2D(F64(ulon), F64(ulat)) * V2D(src.size))
          let sample = src.el(samplePos)
          #if false
          let u8:U8 = v.t.x.clampToUnitAndConvertToU8
          let v8:U8 = v.t.y.clampToUnitAndConvertToU8
          let texPix = V4U8(u8, v8, u8, 0xff)
          #endif
          dst.setEl(V2I(x, y), sample)
        }
      }
    }
  }


  class func triangle() -> Mesh {
    // Two-sided triangle in the unit cube, with vertex radius of 1.
    let x: Flt = sqrt(3.0) * 0.5
    let m = Mesh(name: "triangle")
    m.positions = [
      V3(0, -1, 0),
      V3( x, 0.5, 0),
      V3(-x, 0.5, 0),
    ]
    m.triangles = [
      Tri(0, 1, 2),
      Tri(0, 2, 1),
    ]
    // Note: we cannot add adjacencies because there should be three of them between the front and back faces.
    m.addNormalsFromOriginToPositions()
    return m
  }
}
