// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


public func zip3<S0, S1, S2>(_ seq0: S0, _ seq1: S1, _ seq2: S2) -> Zip3Sequence<S0, S1, S2> {
  return Zip3Sequence(seq0, seq1, seq2)
}


public func zip3<S01, S2, E0, E1>(_ seq01: S01, _ seq2: S2) -> Zip21Sequence<S01, S2, E0, E1> {
  return Zip21Sequence(seq01, seq2)
}


public func enumZip<S1, S2>(_ seq1: S1, _ seq2: S2) -> Zip3Sequence<CountableClosedRange<Int>, S1, S2> {
   return Zip3Sequence(0...Int.max, seq1, seq2)
}


public struct Zip3Iterator<I0: IteratorProtocol, I1: IteratorProtocol, I2: IteratorProtocol> : IteratorProtocol {

  public typealias Element = (I0.Element, I1.Element, I2.Element)

  private var it0: I0
  private var it1: I1
  private var it2: I2

  public init(_ it0: I0, _ it1: I1, _ it2: I2) {
    self.it0 = it0
    self.it1 = it1
    self.it2 = it2
  }

  public mutating func next() -> Element? {
    // Note: unlike Zip2Iterator, we do not track reachedEnd state.
    if let el0 = it0.next(), let el1 = it1.next(), let el2 = it2.next() {
      return (el0, el1, el2)
    }
    return nil
  }
}


public struct Zip3Sequence <S0: Sequence, S1: Sequence, S2: Sequence>: Sequence {

  public typealias Iterator = Zip3Iterator<S0.Iterator, S1.Iterator, S2.Iterator>

  private let seq0: S0
  private let seq1: S1
  private let seq2: S2

  public init(_ seq0: S0, _ seq1: S1, _ seq2: S2) {
    self.seq0 = seq0
    self.seq1 = seq1
    self.seq2 = seq2
  }

  public func makeIterator() -> Iterator {
    return Iterator(seq0.makeIterator(), seq1.makeIterator(), seq2.makeIterator())
  }
}


public struct Zip21Iterator <I01: IteratorProtocol, I2: IteratorProtocol, E0, E1> : IteratorProtocol where I01.Element == (E0, E1) {

  public typealias E2 = I2.Element
  public typealias Element = (E0, E1, E2)

  private var it01: I01
  private var it2: I2

  public init(_ it01: I01, _ it2: I2) {
    self.it01 = it01
    self.it2 = it2
  }

  public mutating func next() -> Element? {
    // Note: unlike Zip2Iterator, we do not track reachedEnd state.
    if let el01 = it01.next(), let el2 = it2.next() {
      return (el01.0, el01.1, el2)
    }
    return nil
  }
}


public struct Zip21Sequence <S01: Sequence, S2: Sequence, E0, E1>: Sequence where S01.Iterator.Element == (E0, E1) {

  public typealias Iterator = Zip21Iterator<S01.Iterator, S2.Iterator, E0, E1>

  private let seq01: S01
  private let seq2: S2

  public init(_ seq01: S01, _ seq2: S2) {
    self.seq01 = seq01
    self.seq2 = seq2
  }

  public func makeIterator() -> Iterator {
    return Iterator(seq01.makeIterator(), seq2.makeIterator())
  }
}

