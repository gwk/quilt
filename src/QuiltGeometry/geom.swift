// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation




func eulerEdgeCount(_ vertexCount: Int, faceCount: Int) -> Int {
  return vertexCount + faceCount - 2
}

