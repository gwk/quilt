// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Dispatch


extension DispatchTime {

  public static func fromNow(_ seconds: Double) -> DispatchTime {
    now() + seconds
  }
}
