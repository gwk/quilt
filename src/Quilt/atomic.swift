// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin
import Darwin.C.stdatomic // swift 3.1 does not expose atomic_fetch_add_explicit, so cannot fix deprecation warning below.


public func atmInc(_ ptr: UnsafeMutablePointer<I64>) { OSAtomicIncrement64(ptr) }
public func atmDec(_ ptr: UnsafeMutablePointer<I64>) { OSAtomicDecrement64(ptr) }


public class AtmCounters {
  private var _counters: Array<I64>
  
  public init(count: Int) {
    _counters = Array<I64>(repeating: 0, count: count)
  }
  
  public var count: Int { return _counters.count }
  
  public subscript (idx: Int) -> I64 { return _counters[idx] }
  
  public func withPtr(_ idx: Int, body: (UnsafeMutablePointer<I64>)->()) {
    assert(idx < count)
    self._counters.withUnsafeMutableBufferPointer() {
      (buffer: inout UnsafeMutableBufferPointer<I64>) -> () in
      body(buffer.baseAddress! + idx)
    }
  }
  
  public func inc(_ idx: Int) {
    withPtr(idx) {
      atmInc($0)
    }
  }
  
  public func dec(_ idx: Int) {
    withPtr(idx) {
      atmDec($0)
    }
  }
  
  public func zeroAll() {
    for i in 0..<count {
      _counters[i] = 0
    }
  }
}

