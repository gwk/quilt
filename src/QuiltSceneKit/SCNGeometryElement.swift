// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import SceneKit


extension SCNGeometryElement {

  public convenience init<I>(points: [I]) where I: FixedWidthInteger {
    self.init(indices: points, primitiveType: .point)
  }

  public convenience init<I>(segments: [Seg<I>]) {
    self.init(data: segments.withUnsafeBytes { Data(bufferPointer: $0) },
              primitiveType: .line,
              primitiveCount: segments.count,
              bytesPerIndex: MemoryLayout<I>.size)
  }

  public convenience init<I>(triangles: [Tri<I>]) {
    self.init(data: triangles.withUnsafeBytes { Data(bufferPointer: $0) },
              primitiveType: .triangles,
              primitiveCount: triangles.count,
              bytesPerIndex: MemoryLayout<I>.size)
  }
}


