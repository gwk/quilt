// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


extension Array: DefaultInitializable {

  public var lastIndex: Int? { return count > 0 ? count - 1 : nil }

  public init(capacity: Int) {
    self = []
    self.reserveCapacity(capacity)
  }

  public init<S: Sequence>(join sequences: S...) where S.Iterator.Element == Iterator.Element {
    self = []
    for s in sequences {
      append(contentsOf: s)
    }
  }

  public func optEl(_ index: Int) -> Element? {
    if index >= 0 && index < count {
      return self[index]
    } else {
      return nil
    }
  }

  public mutating func appendOpt(_ optEl: Element?) {
    if let el = optEl {
      append(el)
    }
  }

  public mutating func put(_ index: Int, el: Element, dflt: Element) {
    if index < count {
      self[index] = el
    } else {
      reserveCapacity(index + 1)
      while count < index {
        append(dflt)
      }
      append(el)
    }
  }

  public mutating func removeBySwappingLast(_ index: Int) -> Element {
    let last = self.removeLast()
    if index != count {
      let val = self[index]
      self[index] = last
      return val
    } else {
      return last
    }
  }

  @inline(__always)
  public func withBuffer<R>(_ body: (Buffer<Array.Element>) throws -> R) rethrows -> R {
    return try withUnsafeBufferPointer(body)
  }

  @inline(__always)
  public mutating func withMutBuffer<R>(_ body: (inout MutBuffer<Array.Element>) throws -> R) rethrows -> R {
    return try withUnsafeMutableBufferPointer(body)
  }

  public func withBufferRebound<T, Result>(to type: T.Type, _ body: (Buffer<T>) throws -> Result) rethrows -> Result {
    let origSize = MemoryLayout<Element>.size
    let castSize = MemoryLayout<T>.size
    let reboundCount: Int
    if origSize < castSize {
      assert(castSize % origSize == 0)
      reboundCount = count / (castSize / origSize)
    } else if origSize > castSize {
      assert(origSize % castSize == 0)
      reboundCount = count * (origSize / castSize)
    } else {
      reboundCount = count
    }
    return try self.withBuffer {
      (buffer) in
      if let baseAddress = buffer.baseAddress {
        return try baseAddress.withMemoryRebound(to: T.self, capacity: reboundCount) {
          (castPtr) in
          return try body(Buffer(start: castPtr, count: reboundCount))
        }
      } else {
        return try body(Buffer<T>(start: nil, count: 0))
      }
    }
  }
}
