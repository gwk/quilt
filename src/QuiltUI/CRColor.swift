// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

#if os(OSX)
  import AppKit
  public typealias CRColor = NSColor
  #else
  import UIKit
  public typealias CRColor = UIColor
#endif

import Quilt
import QuiltArithmetic
import QuiltVec


extension CRColor {

  public class var w: CRColor     { self.white }
  public class var k: CRColor     { self.black }
  public class var r: CRColor     { self.red }
  public class var g: CRColor     { self.green }
  public class var b: CRColor     { self.blue }
  public class var c: CRColor     { self.cyan }
  public class var m: CRColor     { self.magenta }
  public class var y: CRColor     { self.yellow }

  public convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) {
    self.init(red: r, green: g, blue: b, alpha: a)
  }

  public convenience init(ur: U8, ug: U8, ub: U8, a: CGFloat = 1) {
    self.init(red: F64(ur) / 0xff, green: F64(ug) / 0xff, blue: F64(ub) / 0xff, alpha: a)
  }

  public convenience init(l: CGFloat, a: CGFloat = 1) {
    self.init(white: l, alpha: a)
  }

  public convenience init(r: CGFloat, a: CGFloat=1) { self.init(r, 0, 0, a) }
  public convenience init(g: CGFloat, a: CGFloat=1) { self.init(0, g, 0, a) }
  public convenience init(b: CGFloat, a: CGFloat=1) { self.init(0, 0, b, a) }

  public convenience init(v2F v: V2F) {
    self.init(l: F64(v.x), a: F64(v.y))
  }

  public convenience init(v3F v: V3F) {
    self.init(red: F64(v.x), green: F64(v.y), blue: F64(v.z), alpha: 1)
  }

  public convenience init(v4F v: V4F) {
    self.init(red: F64(v.x), green: F64(v.y), blue: F64(v.z), alpha: F64(v.w))
  }

  public var a: F64 {
    var l: CGFloat = 0, a: CGFloat = 0
    #if os(OSX)
      self.getWhite(&l, alpha: &a)
      #else
      let ok = self.getWhite(&l, alpha: &a)
      assert(ok)
    #endif
    return a
  }

  public var l: F64 {
    var l: CGFloat = 0, a: CGFloat = 0
    #if os(OSX)
      self.getWhite(&l, alpha: &a)
      #else
      let ok = self.getWhite(&l, alpha: &a)
      assert(ok)
    #endif
    return l
  }

  public var r: F64 {
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    #if os(OSX)
      self.getRed(&r, green: &g, blue: &b, alpha: &a)
      #else
      let ok = self.getRed(&r, green: &g, blue: &b, alpha: &a)
      assert(ok)
    #endif
    return r
  }

  public var g: F64 {
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    #if os(OSX)
      self.getRed(&r, green: &g, blue: &b, alpha: &a)
      #else
      let ok = self.getRed(&r, green: &g, blue: &b, alpha: &a)
      assert(ok)
    #endif
    return g
  }

  public var b: F64 {
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    #if os(OSX)
      self.getRed(&r, green: &g, blue: &b, alpha: &a)
      #else
      let ok = self.getRed(&r, green: &g, blue: &b, alpha: &a)
      assert(ok)
    #endif
    return b
  }
}
