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


public protocol ArithmeticInt: ArithmeticProtocol, BinaryInteger {}

extension Int: ArithmeticInt {}
extension I8:  ArithmeticInt {}
extension I16: ArithmeticInt {}
extension I32: ArithmeticInt {}
extension I64: ArithmeticInt {}

extension Uns: ArithmeticInt {}
extension U8:  ArithmeticInt {}
extension U16: ArithmeticInt {}
extension U32: ArithmeticInt {}
extension U64: ArithmeticInt {}


