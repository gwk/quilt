// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Dispatch


public class Locked<T: AnyObject> {
  // T must be a public class type; otherwise it would have value semantics and locking would be pointless.
  
  private let _protected: T
  private let _semaphore: DispatchSemaphore
  
  public private(set) var blockedCount: Int = 0
  public private(set) var accessCount: Int = 0
  
  public init(_ initial: T) {
    _protected = initial
    _semaphore = DispatchSemaphore(value: 1) // allow a single accessor at a time.
  }
  
  public func access<R>(_ accessor: @noescape (T) -> R) -> R {
    // access the locked data.
    _ = _semaphore.wait(timeout: DispatchTime.distantFuture)
    let ret = accessor(_protected)
    let didAwakeBlocked = _semaphore.signal()
    if (didAwakeBlocked != 0) {
      blockedCount += 1
    }
    accessCount += 1
    return ret
  }
  
  @warn_unused_result
  public func statsDesc() -> String {
    return "frac: \(Float(blockedCount) / Float(accessCount)); blocked: \(blockedCount); total: \(accessCount)."
  }
}

