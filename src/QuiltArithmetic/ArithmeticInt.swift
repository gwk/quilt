// © 2019 George King. Permission to use this file is granted in license-quilt.txt.


public typealias Uns = UInt

public typealias I8  = Int8
public typealias I16 = Int16
public typealias I32 = Int32
public typealias I64 = Int64

public typealias U8  = UInt8
public typealias U16 = UInt16
public typealias U32 = UInt32
public typealias U64 = UInt64


extension BinaryInteger {

  public var asF32: F32 { return F32(self) }
  public var asF64: F64 { return F64(self) }
  public var asInt: Int { return Int(self) }

}

public protocol SignedArithmeticInt: SignedArithmeticProtocol, BinaryInteger {}

public protocol UnsignedArithmeticInt: ArithmeticProtocol, BinaryInteger {}


extension Int: SignedArithmeticInt {}
extension I8:  SignedArithmeticInt {}
extension I16: SignedArithmeticInt {}
extension I32: SignedArithmeticInt {}
extension I64: SignedArithmeticInt {}

extension Uns: UnsignedArithmeticInt {}
extension U8:  UnsignedArithmeticInt {}
extension U16: UnsignedArithmeticInt {}
extension U32: UnsignedArithmeticInt {}
extension U64: UnsignedArithmeticInt {}


