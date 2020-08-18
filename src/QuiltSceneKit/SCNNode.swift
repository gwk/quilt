// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import SceneKit
import QuiltVec


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


  public var simdPivotPosition: V3S {
    get { return V3S(simdPivot[3]) }
    set {
      var t = simdPivot[3]
      t[0] = newValue[0]
      t[1] = newValue[1]
      t[2] = newValue[2]
      simdPivot[3] = t
    }
  }

  public var simdPivotZ: Float {
    get { return simdPivot[3][2] }
    set { simdPivot[3][2] = newValue }
  }
}
