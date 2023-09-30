// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Dispatch


extension DispatchSource {

  public var isCanceled: Bool { self.isCancelled }
}
