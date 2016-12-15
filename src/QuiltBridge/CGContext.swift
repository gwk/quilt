// © 2015 George King. Permission to use this file is granted in license-qk.txt.

import CoreGraphics


extension CGContext {

  public var w: Int { return self.width }
  public var h: Int { return self.height }
  public var bounds: CGRect { return CGRect(0, 0, Flt(w), Flt(h)) }

  public func flipCTMHori() {
    translateBy(x: Flt(w), y: 0)
    scaleBy(x: -1, y: 1)
  }

  public func setFillColor(r: Flt, g: Flt, b: Flt, a: Flt = 1) {
    self.setFillColor(red: r, green: g, blue: b, alpha: a)
  }

  /*
  public func setFillColor(_ color: V4S) {
    self.setFillColor(red: Flt(color.r), green: Flt(color.g), blue: Flt(color.b), alpha: Flt(color.a))
  }

  public func setFillColor(_ color: V3S) {
    self.setFillColor(red: Flt(color.r), green: Flt(color.g), blue: Flt(color.b), alpha: 1)
  }
*/

  public func clearBounds() { self.clear(bounds) }

  public func fillBounds() { self.fill(bounds) }

  public func draw(image: CGImage, rect: CGRect? = nil) {
    self.draw(image, in: rect.or(bounds))
  }

  public func createImage() -> CGImage {
    return self.makeImage()!
  }
}
