// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import SceneKit
import Quilt


extension SCNTransaction {

  public class func animate(_ duration: Double = 0.25, timing: CAMediaTimingFunctionName = .default, body: Action) {
    begin()
    animationDuration = duration
    animationTimingFunction = CAMediaTimingFunction(name: timing)
    body()
    commit()
  }
}

