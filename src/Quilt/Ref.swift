// © 2016 George King. Permission to use this file is granted in license.txt.

import Foundation


public class Ref<Val> {
  public var val: Val

  public init(_ val: Val) {
    self.val = val
  }
}


extension Ref where Val: DefaultInitializable {
  public convenience init() {
    self.init(Val())
  }
}
