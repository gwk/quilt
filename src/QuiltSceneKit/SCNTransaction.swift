// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

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

