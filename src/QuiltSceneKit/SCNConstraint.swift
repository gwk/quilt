// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

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
