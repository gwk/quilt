// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import SpriteKit


extension SKNode {

  @objc public convenience init(name: String) {
    self.init()
    self.name = name
  }

  public var pos: CGPoint {
    get { position }
    set { position = newValue }
  }


  @discardableResult
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
