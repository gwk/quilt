// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


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
