// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Dispatch


// MARK: async

public func async(_ queue: DispatchQueue = DispatchQueue.main, action: Action) {
  queue.async(execute: action)
}


public func async_after(_ delay: Time, queue: DispatchQueue = DispatchQueue.main, action: Action) {
  let nanoseconds = delay * 1000000000
  queue.after(when: DispatchTime.now() + Double(I64(nanoseconds)) / Double(NSEC_PER_SEC), execute: action)
}

// MARK: sync

public func sync(_ queue: DispatchQueue = DispatchQueue.main, action: Action) {
  queue.sync(execute: action);
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
