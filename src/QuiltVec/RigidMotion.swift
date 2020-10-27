// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

public struct RigidMotion {
  public var position: V3F = .zero
  public var orientation: QF = QF()
  
  public init(position: V3F = .zero, orientation: QF = QF()) {
    self.position = position
    self.orientation = orientation
  }

  static let zero = RigidMotion()
}
