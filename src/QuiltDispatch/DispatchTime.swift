// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Dispatch


extension DispatchTime {

  public static func fromNow(_ seconds: Double) -> DispatchTime {
    now() + seconds
  }
}
