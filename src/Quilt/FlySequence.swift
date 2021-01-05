// © 2021 George King. Permission to use this file is granted in license-quilt.txt.


struct FlySequence<State, Element>: Sequence, IteratorProtocol {

  var state: State
  let nextFn: (inout State) -> Element?

  init(state: State, nextFn: @escaping (inout State) -> Element?) {
    self.state = state
    self.nextFn = nextFn
  }

  mutating func next() -> Element? {
    return nextFn(&state)
  }
}
