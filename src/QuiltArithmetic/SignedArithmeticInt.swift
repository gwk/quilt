// © 2019 George King. Permission to use this file is granted in license-quilt.txt.


public typealias I8  = Int8
public typealias I16 = Int16
public typealias I32 = Int32
public typealias I64 = Int64


public protocol SignedArithmeticInt: SignedArithmeticProtocol, FixedWidthInteger {}


extension Int: SignedArithmeticInt {}
extension I8:  SignedArithmeticInt {}
extension I16: SignedArithmeticInt {}
extension I32: SignedArithmeticInt {}
extension I64: SignedArithmeticInt {}
