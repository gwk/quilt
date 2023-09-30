// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public protocol SignedArithmeticProtocol: SignedNumeric, ArithmeticProtocol {}


public extension SignedArithmeticProtocol {

  func clampSymmetric(_ magnitude: Self) -> Self {
    if self < -magnitude { return -magnitude }
    if self > magnitude { return magnitude }
    return self
  }
}
