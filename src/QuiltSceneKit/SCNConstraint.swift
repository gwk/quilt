// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import SceneKit


extension SCNConstraint {

  public class func trackingTransform(of trackedNode: SCNNode) -> SCNConstraint {
    return SCNTransformConstraint(inWorldSpace: true) {
      (node, transform) in
      trackedNode.worldTransform
    }
  }


  public class func trackingPosition(of trackedNode: SCNNode) -> SCNConstraint {
    return SCNTransformConstraint.positionConstraint(inWorldSpace: true) {
      (node, position) in
      trackedNode.position
    }
  }
}
