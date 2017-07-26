// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import SceneKit
import Quilt


extension SCNGeometryElement {

  public convenience init<C: Collection>(indices: C, vertexCount: Int, primitiveType: SCNGeometryPrimitiveType) where C.Element == Int {
    // TODO: make vertexCount optional; if nil, calculate indices.max.
    if vertexCount <= U16.max {
      self.init(indices: indices.map { U16($0) }, primitiveType: primitiveType)
    } else  if vertexCount < U32.max {
      self.init(indices: indices.map { U32($0) }, primitiveType: primitiveType)
    } else {
      fatalError("vertexCount exceeded U32.max: \(vertexCount)")
    }
  }
}


