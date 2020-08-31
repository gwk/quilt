// © 2020 George King. Permission to use this file is granted in license-quilt.txt.


public protocol SignedArithmeticProtocol: ArithmeticProtocol {
  static prefix func -(s: Self) -> Self
}


extension SignedArithmeticProtocol {

  public func clampSymmetric(_ magnitude: Self) -> Self {
    if self < -magnitude { return -magnitude }
    if self > magnitude { return magnitude }
    return self
  }
}

public func sign<T: SignedArithmeticProtocol>(_ b: Bool) -> T {
  b ? 1 : -1
}

