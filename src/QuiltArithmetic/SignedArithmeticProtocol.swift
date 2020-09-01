// © 2020 George King. Permission to use this file is granted in license-quilt.txt.


public protocol SignedArithmeticProtocol: SignedNumeric, ArithmeticProtocol {}


public extension SignedArithmeticProtocol {

  func clampSymmetric(_ magnitude: Self) -> Self {
    if self < -magnitude { return -magnitude }
    if self > magnitude { return magnitude }
    return self
  }
}

