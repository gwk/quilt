// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import SpriteKit
import QuiltUI


extension SKPhysicsBody {

  // NOTE: as of Xcode 8.2 convenience inits compile and link but result in unrecognized selector exceptions.
  // Presumably this is because SKPhysicsBody is actually PKPhysicsBody and the objc category registration is broken by the rename.

  #if false // disabled until fixed; use alternatives below.
  public convenience init(polygonPoints: [CGPoint]) {
    self.init(polygonFrom: CGPath.with(loopPoints: polygonPoints))
  }

  public convenience init(edgeLoopPoints: [CGPoint]) {
    self.init(edgeLoopFrom: CGPath.with(loopPoints: edgeLoopPoints))
  }

  public convenience init(size: CGSize, anchor: CGPoint) {
    self.init(rectangleOfSize: size, center: V2(size) * (V2(0.5, 0.5) - anchor))
  }
  #endif

  public class func with(polygonPoints: [CGPoint]) -> SKPhysicsBody {
    SKPhysicsBody(polygonFrom: CGPath.with(loopPoints: polygonPoints))
  }

  public class func with(edgeLoopPoints: [CGPoint]) -> SKPhysicsBody {
    SKPhysicsBody(edgeLoopFrom: CGPath.with(loopPoints: edgeLoopPoints))
  }

  public class func with(size: CGSize, anchor: CGPoint) -> SKPhysicsBody { // workaround for above.
    SKPhysicsBody(rectangleOf: size, center: V2(size) * (V2(0.5, 0.5) - anchor))
  }

  public class func matching(spriteNode: SKSpriteNode) -> SKPhysicsBody {
    SKPhysicsBody.with(size: spriteNode.size, anchor: spriteNode.anchorPoint)
  }
}
