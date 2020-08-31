// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import SpriteKit
import Quilt


extension SKAction {

  public class func runNodeBlock<Node: SKNode>(_ block: @escaping (Node)->()) -> SKAction {
    SKAction.customAction(withDuration: 0) {
      (node: SKNode, elapsedTime: CGFloat) in
      if let node = node as? Node {
        block(node)
      } else {
        errL("runNodeBlock cast `SKNode as? \(Node.self)` failed for node: \(node)")
      }
    }
  }

  public func delay(_ duration: Time) -> SKAction { SKAction.sequence([SKAction.wait(forDuration: duration), self]) }

  public func repeated(_ count: Int) -> SKAction { SKAction.repeat(self, count: count) }

  public var forever: SKAction { SKAction.repeatForever(self) }

  public class func showTexts(_ texts: [String], durationPerItem: Time) -> SKAction {
    var actions: [SKAction] = [SKAction.unhide()]
    for text in texts {
      actions.append(SKAction.runNodeBlock {
        (node: SKLabelNode) in
        node.text = text
      })
      actions.append(SKAction.wait(forDuration: durationPerItem))
    }
    actions.append(SKAction.hide())
    return SKAction.sequence(actions)
  }
}
