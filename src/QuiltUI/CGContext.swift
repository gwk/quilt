// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import CoreGraphics
#if os(OSX)
  import AppKit
#else
  import UIKit
#endif

import Quilt
import QuiltVec


extension CGContext {


  public static func from(image: CGImage) -> CGContext {
    let ctx = CGContext(data: nil, width: image.width, height: image.height, bitsPerComponent: image.bitsPerComponent,
      bytesPerRow: image.bytesPerRow, space: image.colorSpace!, bitmapInfo: image.bitmapInfo.rawValue)!
    ctx.draw(image, in: image.bounds)
    return ctx
  }


  public static func makeBGRA8(ptr: UnsafeMutableRawPointer, size: V2I, space: CGColorSpace = .displayP3Space) -> CGContext {
    let info: CGBitmapInfo = [.byteOrder32Little, .premultipliedFirst]
    return CGContext(data: ptr, width: size.x, height: size.y, bitsPerComponent: 8, bytesPerRow: size.x * 4, space: space, bitmapInfo: info.rawValue)!
  }


  public var w: Int { self.width }
  public var h: Int { self.height }
  public var bounds: CGRect { CGRect(0, 0, Double(w), Double(h)) }

  public func flipCTMHori() {
    translateBy(x: Double(w), y: 0)
    scaleBy(x: -1, y: 1)
  }

  public func setFillColor(r: Double, g: Double, b: Double, a: Double = 1) {
    self.setFillColor(red: r, green: g, blue: b, alpha: a)
  }

  /*
  public func setFillColor(_ color: V4F) {
    self.setFillColor(red: Double(color.r), green: Double(color.g), blue: Double(color.b), alpha: Double(color.a))
  }

  public func setFillColor(_ color: V3F) {
    self.setFillColor(red: Double(color.r), green: Double(color.g), blue: Double(color.b), alpha: 1)
  }
*/

  public func clearBounds() { self.clear(bounds) }

  public func fillBounds() { self.fill(bounds) }

  public func draw(image: CGImage, rect: CGRect? = nil) {
    self.draw(image, in: rect ?? bounds)
  }

  public func createImage() -> CGImage { self.makeImage()! }

  public func withGraphicsContext(flipped: Bool, body: Action) {
    NSGraphicsContext.current = NSGraphicsContext(cgContext: self, flipped: flipped)
    body()
    NSGraphicsContext.current = nil
  }
}


extension CGBitmapInfo {

  public static var premultipliedFirst: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)

}
