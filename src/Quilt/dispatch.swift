// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Dispatch


// MARK: async

public func async(action: @escaping Action) {
  DispatchQueue.main.async(execute: action)
}


public func async(after delay: Time, action: @escaping Action) {
  let nanoseconds = delay * 1000000000
  DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(I64(nanoseconds)) / Double(NSEC_PER_SEC), execute: action)
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
