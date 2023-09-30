// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Darwin


public typealias F32 = Float
public typealias F64 = Double

public protocol ArithmeticFloat: SignedArithmeticProtocol, BinaryFloatingPoint {}

extension F32: ArithmeticFloat {}
extension F64: ArithmeticFloat {}
