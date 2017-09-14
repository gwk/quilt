// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import CoreGraphics


extension CGPath {

  public static func with(loopPoints points: [CGPoint]) -> CGPath {
    let path = CGMutablePath()
    path.addLines(between: points)
    path.closeSubpath()
    return path
  }
}


extension CGMutablePath {}
