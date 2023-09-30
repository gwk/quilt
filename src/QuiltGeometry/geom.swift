// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public func eulerEdgeCount(_ vertexCount: Int, faceCount: Int) -> Int {
  vertexCount + faceCount - 2
}
