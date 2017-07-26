// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import SceneKit
import Quilt
import QuiltBridge
import QuiltSceneKit


enum GeomKind {
  case point
  case seg
  case tri
}

class Mesh {
  var name: String? = nil
  var positions: [V3] = []
  var normals: [V3] = []
  var colors: [V4] = []
  var texture0s: [V2] = []
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

  func printContents() {
    print("Mesh:")
    for (i, pos) in positions.enumerated() {
      print("  p[\(i)] = \(pos)")
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
        if d > 0 && d < length {
          print(d, a, b)
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

  func geometry(kind: GeomKind = .tri) -> SCNGeometry {

    let len = positions.count

    // data offsets.
    let op = 0 // position data is required.
    var on = 0
    var oc = 0
    var ot0 = 0
    #if false // TODO: creases.
      var ovc = 0
      var oec = 0
    #endif
    #if false // TODO: bones.
      var obw = 0
    var obi = 0
    #endif

    var stride = MemoryLayout<V3S>.size
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
    if !texture0s.isEmpty {
      assert(texture0s.count == len)
      ot0 = stride
      stride += MemoryLayout<V2S>.size
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
    let d = NSMutableData(capacity: len * stride)!

    for i in 0..<len {
      d.append(positions[i].vs)
      if !normals.isEmpty         { d.append(normals[i].vs) }
      if !colors.isEmpty          { d.append(colors[i].vs) }
      if !texture0s.isEmpty       { d.append(texture0s[i].vs) }
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
    if !texture0s.isEmpty {
      sources.append(SCNGeometrySource(
        data: d as Data,
        semantic: SCNGeometrySource.Semantic.texcoord,
        vectorCount: len,
        usesFloatComponents: true,
        componentsPerVector: 2,
        bytesPerComponent: MemoryLayout<F32>.size,
        dataOffset: ot0,
        dataStride: stride))
    }

    let element: SCNGeometryElement
    switch kind {
    case .point:
      element = SCNGeometryElement(indices: points, vertexCount: positions.count, primitiveType: .point)
    case .seg:
      element = segments.withUnsafeBufferPointerRebound(to: Int.self) {
        SCNGeometryElement(indices: $0, vertexCount: positions.count, primitiveType: .line)
      }
    case .tri:
      element = triangles.withUnsafeBufferPointerRebound(to: Int.self) {
        SCNGeometryElement(indices: $0, vertexCount: positions.count, primitiveType: .triangles)
      }
    }
    return SCNGeometry(sources: sources, elements: [element])
  }

  class func triangle() -> Mesh {
    let r: Flt = sqrt(1.0 / 3.0) // radius of insphere.
    let m = Mesh(name: "triangle")
    m.positions = [
      V3(-r, -r, -r),
      V3(-r,  r,  r),
      V3( r,  r, -r),
    ]
    m.triangles = [
      Tri(0, 1, 2),
      Tri(0, 2, 1),
    ]
    return m
  }
}

