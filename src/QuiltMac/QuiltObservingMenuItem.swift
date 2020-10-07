// © 2020 George King. Permission to use this file is granted in license-quilt.txt.


import AppKit
import QuiltDispatch


public class QuiltObservingMenuItem: NSMenuItem {

  public var observations: [NSKeyValueObservation]

  required init(coder: NSCoder) { fatalError() }


  public init(title: String, action selector: Selector?, keyEquivalent charCode: String, observations: [NSKeyValueObservation] = []) {
    self.observations = observations
    super.init(title: title, action: selector, keyEquivalent: charCode)
  }


  public func invalidate() {
    observations.forEach { $0.invalidate() }
  }


  public func observe<Observable: NSObject, Value: Any>(
    observable: Observable, keyPath: KeyPath<Observable, Value>, options: NSKeyValueObservingOptions = [],
    changeHandler: @escaping (QuiltObservingMenuItem, Observable, NSKeyValueObservedChange<Value>) -> Void) {
    // Add an observation, wrapping the normal `observe(keyPath, options, changeHandler)` changeHandler block
    // so that the handler is executed on the main (UI-safe) thread and passes self: NSMenuItem as the first argument.
    let observation = observable.observe(keyPath, options: options) {
      [weak self] (observable, observedChange) in
      if let self = self {
        async {
          changeHandler(self, observable, observedChange)
        }
      }
    }
    observations.append(observation)
  }
}
