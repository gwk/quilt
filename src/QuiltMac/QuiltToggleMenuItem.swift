// © 2021 George King. Permission to use this file is granted in license-quilt.txt.


import AppKit
import QuiltDispatch


public class QuiltToggleMenuItem<Observable: NSObject>: NSMenuItem {

  public var observable: Observable
  public var observation: NSKeyValueObservation? = nil
  public let keyPath: WritableKeyPath<Observable, Bool>
  public let inverted: Bool

  required init(coder: NSCoder) { fatalError() }


  public init(title: String, key: String = "", observable: Observable, keyPath: WritableKeyPath<Observable, Bool>, inverted: Bool = false) {
    self.observable = observable
    self.keyPath = keyPath
    self.inverted = inverted
    super.init(title: title, action: #selector(toggleBoolValue), keyEquivalent: key)
    self.target = self
    let options: NSKeyValueObservingOptions = [.new, .initial]
    self.observation = observable.observe(keyPath, options: options) {
      [weak self] (observable, change) in
      if let self = self, let val = change.newValue {
        async {
          if self.inverted {
            self.state = val ? .off : .on
          } else {
            self.state = val ? .on : .off
          }
        }
      }
    }
  }


  public func invalidate() {
    observation?.invalidate()
    observation = nil
  }


  @objc public func toggleBoolValue() {
    observable[keyPath: keyPath] = !observable[keyPath: keyPath]
  }
}
