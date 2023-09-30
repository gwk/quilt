// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

public struct RigidMotion {
  public var position: V3F = .zero
  public var orientation: QF = QF()

  public init(position: V3F = .zero, orientation: QF = QF()) {
    self.position = position
    self.orientation = orientation
  }

  static let zero = RigidMotion()
}
