// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


extension Comparable {

  public func clamp(min: Self, max: Self) -> Self {
    if self < min { return min }
    if self > max { return max }
    return self
  }
}
