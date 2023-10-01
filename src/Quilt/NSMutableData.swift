// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


extension NSMutableData {

  public func append<T>(_ el: T) {
    withUnsafeBytes(of: el) {
      self.append($0.baseAddress!, length: MemoryLayout<T>.size)
    }
  }
}
