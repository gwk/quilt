// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Dispatch


extension DispatchTime {

  @warn_unused_result
  public static func fromNow(_ seconds: Double) -> DispatchTime {
    return now() + seconds
  }
}
