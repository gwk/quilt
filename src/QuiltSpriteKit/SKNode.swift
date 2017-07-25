// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import SpriteKit


extension SKNode {

  public convenience init(name: String) {
    self.init()
    self.name = name
  }

  public var pos: CGPoint {
    get { return position }
    set { position = newValue }
  }


  public func add<T: SKNode>(_ child: T) -> T {
    addChild(child)
    return child
  }

  public func addChildren(_ children: [SKNode]) {
    for c in children {
      addChild(c)
    }
  }
}
