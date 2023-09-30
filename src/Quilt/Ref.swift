// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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
