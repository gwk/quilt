// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


extension NSMutableData {

  public func append<T>(_ el: T) { var el = el; self.append(&el, length: MemoryLayout<T>.size) }
}
