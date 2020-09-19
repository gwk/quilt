// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

import SceneKit
import QuiltArithmetic
import QuiltGeometry
import QuiltVec


extension Mesh {


  public func geometry(kinds: [GeomKind] = [.tri]) -> SCNGeometry {

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

    var stride = MemoryLayout<V3F>.size // always have positions.
    if !normals.isEmpty {
      assert(normals.count == len)
      on = stride
      stride += MemoryLayout<V3F>.size
    }
    if !colors.isEmpty {
      assert(colors.count == len)
      oc = stride
      stride += MemoryLayout<V4F>.size
    }
    for texCoords in textures {
      if !texCoords.isEmpty {
        assert(texCoords.count == len)
        ots.append(stride)
        stride += MemoryLayout<V2F>.size
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
      d.append(positions[i].vf)
      if !normals.isEmpty         { d.append(normals[i].vf) }
      if !colors.isEmpty          { d.append(colors[i].vf) }
      for texCoords in textures {
        if !texCoords.isEmpty       { d.append(texCoords[i].vf) }
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
        element.pointSize = CGFloat(size)
        element.minimumPointScreenSpaceRadius = CGFloat(minRad)
        element.maximumPointScreenSpaceRadius = CGFloat(maxRad)
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
}