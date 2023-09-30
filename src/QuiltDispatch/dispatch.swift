// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Dispatch


// MARK: async

public func async(action: @escaping () -> Void) {
  DispatchQueue.main.async(execute: action)
}


public func async(after delay: Double, action: @escaping () -> Void) {
  let nanoseconds = delay * 1000000000
  DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(nanoseconds)) / Double(NSEC_PER_SEC), execute: action)
}


// MARK: printing

public func outLLA(_ items: [String]) {
  async() {
    for i in items {
      print(i)
    }
  }
}

public func outLLA(_ items: String...) { outLLA(items) }
