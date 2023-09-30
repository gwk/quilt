// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import SceneKit
import Quilt


extension SCNTransaction {

  public class func animate(_ duration: Double = 0.2, timing: CAMediaTimingFunctionName = .default, body: Action, completion: Action? = nil) {
    begin()
    animationDuration = duration
    animationTimingFunction = CAMediaTimingFunction(name: timing)
    body()
    completionBlock = completion
    commit()
  }
}
