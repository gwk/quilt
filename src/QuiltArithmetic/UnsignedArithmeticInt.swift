// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public typealias Uns = UInt
public typealias U8  = UInt8
public typealias U16 = UInt16
public typealias U32 = UInt32
public typealias U64 = UInt64


public protocol UnsignedArithmeticInt: ArithmeticProtocol, FixedWidthInteger {}

extension Uns: UnsignedArithmeticInt {}
extension U8:  UnsignedArithmeticInt {}
extension U16: UnsignedArithmeticInt {}
extension U32: UnsignedArithmeticInt {}
extension U64: UnsignedArithmeticInt {}
