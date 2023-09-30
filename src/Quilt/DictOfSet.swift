// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public struct DictOfSet<Key: Hashable, SetElement: Hashable>: Collection, ExpressibleByDictionaryLiteral {

  public typealias SetVal = Set<SetElement>
  public typealias SetRef = Ref<SetVal>
  public typealias Dict = [Key:SetRef]
  public typealias Index = Dict.Index
  public typealias Element = Dict.Element
  public typealias Iterator = Dict.Iterator

  private var dict: Dict = [:]

  public init() {}

  public init(minimumCapacity: Int) {
    dict = Dict(minimumCapacity: minimumCapacity)
  }

  public init(dictionaryLiteral elements: (Key, SetVal)...) {
    dict = elements.mapToDict { ($0.0, Ref($0.1)) }
  }

  public var count: Int { dict.count }

  public var startIndex: Index { dict.startIndex }
  public var endIndex: Index { dict.endIndex }

  public var isEmpty: Bool { dict.isEmpty }

  public var keys: Dict.Keys { dict.keys }

  public var values: Dict.Values { dict.values }

  public func makeIterator() -> Iterator { dict.makeIterator() }

  public func index(_ forKey: Key) -> Index? { dict.index(forKey: forKey) }

  public mutating func popFirst() -> Element? { dict.popFirst() }

  public mutating func removeAll(keepCapacity: Bool = false) {
    dict.removeAll(keepingCapacity: keepCapacity)
  }

  public mutating func remove(_ at: Index) -> Element { dict.remove(at: at) }

  public mutating func removeValue(_ forKey: Key) -> SetRef? { dict.removeValue(forKey: forKey) }

  public subscript(index: Index) -> Element { dict[index] }

  public subscript(key: Key) -> SetRef? {
    get { dict[key] }
    set { dict[key] = newValue }
  }

  public func index(after i: Index) -> Index {
    dict.index(after: i)
  }

  public mutating func insert(_ key: Key, member: SetElement) {
    if let ref = dict[key] {
      ref.val.insert(member)
    } else {
      let ref = SetRef([])
      ref.val.insert(member)
      dict[key] = ref
    }
  }
}
