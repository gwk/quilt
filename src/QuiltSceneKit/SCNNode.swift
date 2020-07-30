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
}
