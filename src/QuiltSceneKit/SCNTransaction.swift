// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import SceneKit
import Quilt


extension SCNTransaction {

  class func animate(_ duration: Double = 0.25, body: Action) {
    begin()
    animationDuration = duration
    // TODO: set animationTimingFunction: CAMediaTimingFunction?
    body()
    commit()
  }
}

