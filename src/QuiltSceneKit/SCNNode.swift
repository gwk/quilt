// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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
    get { simdEulerAngles.x }
    set {
      var e = simdEulerAngles
      e.x = newValue
      simdEulerAngles = e
    }
  }


  public var yaw: Float {
    get { simdEulerAngles.y }
    set {
      var e = simdEulerAngles
      e.y = newValue
      simdEulerAngles = e
    }
  }


  public var roll: Float {
    get { simdEulerAngles.z }
    set {
      var e = simdEulerAngles
      e.z = newValue
      simdEulerAngles = e
    }
  }


  public var simdPivotPosition: V3F {
    get { V3F(simdPivot[3]) }
    set {
      var t = simdPivot[3]
      t[0] = newValue[0]
      t[1] = newValue[1]
      t[2] = newValue[2]
      simdPivot[3] = t
    }
  }


  public var simdPivotZ: Float {
    get { simdPivot[3][2] }
    set { simdPivot[3][2] = newValue }
  }


  public var motion: RigidMotion {
    get {
      RigidMotion(position: self.simdPosition, orientation: self.simdOrientation)
    }
    set {
      self.simdPosition = newValue.position
      self.simdOrientation = newValue.orientation
    }
  }


  public var worldMotion: RigidMotion {
    get {
      RigidMotion(position: self.simdWorldPosition, orientation: self.simdWorldOrientation)
    }
    set {
      self.simdWorldPosition = newValue.position
      self.simdWorldOrientation = newValue.orientation
    }
  }


  public func highlight(color: NSColor, duration: TimeInterval = 0.2) {
    // Highlight the selected node with an animation.
    guard let geom = self.geometry else { return }
    let original = geom.materials
    let highlighted = original.map {
      (orig: SCNMaterial) -> SCNMaterial in
      let mat: SCNMaterial = orig.copy() as! SCNMaterial
      mat.emission.contents = color
      return mat
    }
    geom.materials = highlighted
    SCNTransaction.animate(duration) {
      () in
      zip(highlighted, original).forEach {
        $0.emission.contents = $1.emission.contents
      }
    } completion: {
      if geom.firstMaterial == highlighted.first {
        geom.materials = original
      }
    }
  }


  public func hitTestClosest(
    segment: (V3, V3),
    root: SCNNode? = nil,
    ignoreChildren: Bool = false,
    ignoreHidden: Bool = true) -> SCNHitTestResult? {

    let options: [String: Any] = [
      SCNHitTestOption.searchMode.rawValue: SCNHitTestSearchMode.closest.rawValue,
      SCNHitTestOption.rootNode.rawValue: root ?? self,
      SCNHitTestOption.ignoreChildNodes.rawValue: ignoreChildren,
      SCNHitTestOption.ignoreHiddenNodes.rawValue: ignoreHidden,
    ]
    let hits = hitTestWithSegment(from: segment.0, to: segment.1, options: options)
    return hits.isEmpty ? nil : hits[0]
  }
}
