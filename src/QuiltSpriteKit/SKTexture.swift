// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import SpriteKit
import Quilt
import QuiltUI


let SKTexture_missing: SKTexture = SKTexture(cgImage: CoreGraphics.CGImage.missing) // workaround for 2.1b3.


extension SKTexture {

  public static var missing: SKTexture { SKTexture_missing }

  public convenience init(path: Path, filteringMode: SKTextureFilteringMode = .linear) {
    let image: CGImage
    do {
      image = try CGImage.from(path: path)
    } catch let e {
      warn("texture resource load failed: \(String(reflecting: type(of: e))).\(e)")
      image = CoreGraphics.CGImage.missing
    }
    self.init(cgImage: image)
    self.filteringMode = filteringMode
  }

  @available(macOS 10.11, *)
  public var textureByFlippingH: SKTexture {
    let tex = SKTexture(cgImage: self.cgImage().flipH())
    tex.filteringMode = filteringMode
    return tex
  }
}
