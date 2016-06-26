// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


public protocol PixelType {
  associatedtype Scalar
  static var numComponents: Int { get }
}

extension U8: PixelType {
  public typealias Scalar = U8
  public static var numComponents: Int { return 1 }
}

extension F32: PixelType {
  public typealias Scalar = F32
  public static var numComponents: Int { return 1 }
}

extension V2U8: PixelType {
  public static var numComponents: Int { return 2 }
}

extension V3U8: PixelType {
  public static var numComponents: Int { return 3 }
}

extension V4U8: PixelType {
  public static var numComponents: Int { return 4 }
}

extension V2S: PixelType {
  public static var numComponents: Int { return 2 }
}

extension V3S: PixelType {
  public static var numComponents: Int { return 3 }
}

extension V4S: PixelType {
  public static var numComponents: Int { return 4 }
}
