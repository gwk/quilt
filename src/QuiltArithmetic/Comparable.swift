// © 2020 George King. Permission to use this file is granted in license-quilt.txt.


extension Comparable {

  public func clamp(min: Self, max: Self) -> Self {
    if self < min { return min }
    if self > max { return max }
    return self
  }
}
