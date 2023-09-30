// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation
import SceneKit
import Quilt


extension SCNGeometryElement {

  public convenience init<C: Collection>(indices: C, vertexCount: Int, primitiveType: SCNGeometryPrimitiveType) where C.Element == Int {
    // TODO: make vertexCount optional; if nil, calculate indices.max.
    if vertexCount <= UInt16.max {
      self.init(indices: indices.map { UInt16($0) }, primitiveType: primitiveType)
    } else  if vertexCount < UInt32.max {
      self.init(indices: indices.map { UInt32($0) }, primitiveType: primitiveType)
    } else {
      fatalError("vertexCount exceeded UInt32.max: \(vertexCount)")
    }
  }
}
