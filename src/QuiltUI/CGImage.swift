// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import CoreGraphics
import Foundation
import ImageIO
import Quilt
import QuiltArea
import QuiltArithmetic
import QuiltVec
import UniformTypeIdentifiers


extension CGImage {

  public enum Err: Error {
    case jpeg(path: Path)
    case path(path: Path)
    case pathExtension(path: Path)
    case png(path: Path)
  }

  // Question mark icon.
  public static let missing: CGImage = CGImage.with(rowArray:
    RowArray<U8>(size: V2I(8, 8), seq: [
      0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40,
      0x40, 0x80, 0xff, 0xff, 0xff, 0xff, 0x80, 0x40,
      0x40, 0xff, 0xff, 0x80, 0x80, 0xff, 0xff, 0x40,
      0x40, 0xff, 0x80, 0x80, 0x80, 0xff, 0xff, 0x40,
      0x40, 0x80, 0x80, 0x80, 0xff, 0xff, 0x80, 0x40,
      0x40, 0x80, 0x80, 0xff, 0xff, 0x80, 0x80, 0x40,
      0x40, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x40,
      0x40, 0x40, 0x40, 0xff, 0xff, 0x40, 0x40, 0x40,
      ]),
    shouldInterpolate: false)

  public class func from(path: Path, shouldInterpolate: Bool = true, intent: CGColorRenderingIntent = .defaultIntent) throws -> CGImage {
    guard let provider = CGDataProvider(filename: path.expandUser) else {
      throw Err.path(path: path)
    }
    switch path.ext {
    case ".jpg":
      if let i = CGImage(jpegDataProviderSource: provider, decode: nil, shouldInterpolate: shouldInterpolate, intent: intent) {
        return i
      } else { throw Err.jpeg(path: path) }
    case ".png":
      if let i = CGImage(pngDataProviderSource: provider, decode: nil, shouldInterpolate: shouldInterpolate, intent: intent) {
        return i
      } else { throw Err.png(path: path) }
    default: throw Err.pathExtension(path: path)
    }
  }

  public class func with<T: PixelType>(bufferPointer: Buffer<T>, size: V2I, colorSpace: CGColorSpace,
    bitmapInfo: CGBitmapInfo, shouldInterpolate: Bool, intent: CGColorRenderingIntent) -> CGImage {
      let bytesPerComponent = MemoryLayout<T.Scalar>.size
      let bytesPerPixel = MemoryLayout<T>.size
      let bitsPerComponent = 8 * bytesPerComponent
      let bitsPerPixel = 8 * bytesPerPixel
      let bytesPerRow = bytesPerPixel * size.x
      let rawBuffer = UnsafeRawBufferPointer(bufferPointer)
      let data = Data(bytes: rawBuffer.baseAddress!, count: rawBuffer.count)
      let provider = CGDataProvider(data: data as CFData)
      let decodeArray: UnsafePointer<CGFloat>? = nil
      return CGImage(width: size.x, height: size.y,
        bitsPerComponent: bitsPerComponent, bitsPerPixel: bitsPerPixel, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo, provider: provider!, decode: decodeArray, shouldInterpolate: shouldInterpolate, intent: intent)!
  }

  public class func with<T: PixelType>(rowArray: RowArray<T>, shouldInterpolate: Bool = true,
    intent: CGColorRenderingIntent = .defaultIntent) -> CGImage {
      return rowArray.withBuffer {
        let isRGB = T.scalarCount >= 3
        let isFloat = (MemoryLayout<T.Scalar>.size == 4)
        let hasAlpha = (T.scalarCount % 2 == 0)
        let colorSpace = isRGB ? CGColorSpaceCreateDeviceRGB() : CGColorSpaceCreateDeviceGray()
        let byteOrder: CGBitmapInfo
        switch MemoryLayout<T.Scalar>.size {
        case 1: byteOrder = CGBitmapInfo()
        case 2: byteOrder = .byteOrder16Little
        case 4: byteOrder = .byteOrder32Little
        default: fatalError("unsupported PixelType.Scalar: \(T.self)")
        }
        var bitmapInfo: CGBitmapInfo = byteOrder
        if isFloat {
          bitmapInfo.insert(.floatComponents)
        }
        if hasAlpha {
          bitmapInfo.insert(CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)) // TODO: explore if non-premultiplied is supported.
        }
        return with(bufferPointer: $0, size: rowArray.size, colorSpace: colorSpace, bitmapInfo: bitmapInfo, shouldInterpolate: shouldInterpolate, intent: intent)
      }
  }


  public var w: Int { self.width }
  public var h: Int { self.height }
  public var bounds: CGRect { CGRect(Double(w), Double(h)) }


  public func makeBitmapContext() -> CGContext {
    CGContext(data: nil, width: w, height: h, bitsPerComponent: bitsPerComponent, bytesPerRow: 0, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue)!
  }

  public func flipH() -> CGImage {
    let ctx = CGContext(data: nil, width: w, height: h, bitsPerComponent: bitsPerComponent, bytesPerRow: 0, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue)!
    ctx.flipCTMHori()
    ctx.draw(image: self)
    return ctx.createImage()
  }

  public func writePng(path: Path) -> Bool {
    let dst = CGImageDestinationCreateWithURL(path.url as CFURL, UTType.png.identifier as CFString, 1, nil)!
    CGImageDestinationAddImage(dst, self, nil)
    let res = CGImageDestinationFinalize(dst)
    if (!res) {
      warn("failed to write image to path: '\(path)'")
    }
    return res
  }
}
