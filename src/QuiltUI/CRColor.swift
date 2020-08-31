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
    self.init(red: Flt(ur) / 0xff, green: Flt(ug) / 0xff, blue: Flt(ub) / 0xff, alpha: a)
  }

  public convenience init(l: CGFloat, a: CGFloat = 1) {
    self.init(white: l, alpha: a)
  }

  public convenience init(r: CGFloat, a: CGFloat=1) { self.init(r, 0, 0, a) }
  public convenience init(g: CGFloat, a: CGFloat=1) { self.init(0, g, 0, a) }
  public convenience init(b: CGFloat, a: CGFloat=1) { self.init(0, 0, b, a) }

  public convenience init(v2S v: V2S) {
    self.init(l: Flt(v.x), a: Flt(v.y))
  }

  public convenience init(v3S v: V3S) {
    self.init(red: Flt(v.x), green: Flt(v.y), blue: Flt(v.z), alpha: 1)
  }

  public convenience init(v4S v: V4S) {
    self.init(red: Flt(v.x), green: Flt(v.y), blue: Flt(v.z), alpha: Flt(v.w))
  }

  public var a: Flt {
    var l: Flt = 0, a: Flt = 0
    #if os(OSX)
      self.getWhite(&l, alpha: &a)
      #else
      let ok = self.getWhite(&l, alpha: &a)
      assert(ok)
    #endif
    return a
  }

  public var l: Flt {
    var l: Flt = 0, a: Flt = 0
    #if os(OSX)
      self.getWhite(&l, alpha: &a)
      #else
      let ok = self.getWhite(&l, alpha: &a)
      assert(ok)
    #endif
    return l
  }

  public var r: Flt {
    var r: Flt = 0, g: Flt = 0, b: Flt = 0, a: Flt = 0
    #if os(OSX)
      self.getRed(&r, green: &g, blue: &b, alpha: &a)
      #else
      let ok = self.getRed(&r, green: &g, blue: &b, alpha: &a)
      assert(ok)
    #endif
    return r
  }

  public var g: Flt {
    var r: Flt = 0, g: Flt = 0, b: Flt = 0, a: Flt = 0
    #if os(OSX)
      self.getRed(&r, green: &g, blue: &b, alpha: &a)
      #else
      let ok = self.getRed(&r, green: &g, blue: &b, alpha: &a)
      assert(ok)
    #endif
    return g
  }

  public var b: Flt {
    var r: Flt = 0, g: Flt = 0, b: Flt = 0, a: Flt = 0
    #if os(OSX)
      self.getRed(&r, green: &g, blue: &b, alpha: &a)
      #else
      let ok = self.getRed(&r, green: &g, blue: &b, alpha: &a)
      assert(ok)
    #endif
    return b
  }
}
