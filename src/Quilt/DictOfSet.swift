// © 2016 George King. Permission to use this file is granted in license-quilt.txt.


public struct DictOfSet<Key: Hashable, SetElement: Hashable>:
  Collection, ExpressibleByDictionaryLiteral {

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

  public var count: Int { return dict.count }

  public var startIndex: Index { return dict.startIndex }
  public var endIndex: Index { return dict.endIndex }

  public var isEmpty: Bool { return dict.isEmpty }

  public var keys: Dict.Keys { return dict.keys }

  public var values: Dict.Values { return dict.values }

  public func makeIterator() -> Iterator { return dict.makeIterator() }

  public func index(_ forKey: Key) -> Index? { return dict.index(forKey: forKey) }

  public mutating func popFirst() -> Element? { return dict.popFirst() }

  public mutating func removeAll(keepCapacity: Bool = false) {
    dict.removeAll(keepingCapacity: keepCapacity)
  }

  public mutating func remove(_ at: Index) -> Element { return dict.remove(at: at) }

  public mutating func removeValue(_ forKey: Key) -> SetRef? { return dict.removeValue(forKey: forKey) }

  public subscript (index: Index) -> Element { return dict[index] }

  public subscript (key: Key) -> SetRef? {
    get { return dict[key] }
    set { dict[key] = newValue }
  }

  public func index(after i: Index) -> Index {
    return dict.index(after: i)
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
