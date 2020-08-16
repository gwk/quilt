// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import SceneKit


extension SCNNode {

  public convenience init(name: String?) {
    self.init()
    self.name = name
  }


  @discardableResult
  public func add<T: SCNNode>(_ child: T) -> T {
    addChildNode(child)
    return child
  }


  public func addChildren(_ children: [SCNNode]) {
    for c in children {
      addChildNode(c)
    }
  }


  public var pitch: Float {
    get { return simdEulerAngles.x }
    set {
      var e = simdEulerAngles
      e.x = newValue
      simdEulerAngles = e
    }
  }


  public var yaw: Float {
    get { return simdEulerAngles.y }
    set {
      var e = simdEulerAngles
      e.y = newValue
      simdEulerAngles = e
    }
  }

  
  public var roll: Float {
    get { return simdEulerAngles.z }
    set {
      var e = simdEulerAngles
      e.z = newValue
      simdEulerAngles = e
    }
  }
}
