// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import AppKit
import Quilt
import QuiltDispatch


public class QuiltChoiceMenu<Observable: NSObject, ChoiceEnum: MenuEnum>: NSMenu {

  var observable: Observable
  let keyPath: WritableKeyPath<Observable, ChoiceEnum>
  var observation: NSKeyValueObservation? = nil


  required init(coder: NSCoder) { fatalError() }


  public init(title: String,
    observable: Observable,
    keyPath: WritableKeyPath<Observable, ChoiceEnum>,
    options: NSKeyValueObservingOptions = []) {

    self.observable = observable
    self.keyPath = keyPath
    super.init(title: title)

    items = ChoiceEnum.allCases.map {
      (menuChoice) in
      let item = NSMenuItem(title: menuChoice.menuTitle, action: #selector(updateChoice(_:)), keyEquivalent: "")
      item.target = self
      item.tag = menuChoice.rawValue
      return item
    }

    observation = observable.observe(keyPath, options: [.new, .old]) {
      [weak self] (observable, change) in
      if let self = self {
        async {
          if let old = change.oldValue {
            self.items[old.rawValue].state = .off
          }
          if let new = change.newValue {
            self.items[new.rawValue].state = .on
          }
        }
      }
    }

    // Note: we should be able to use the `.initial` option, but it does not work.
    // The initial observation is sent, but for some reason has no newValue (even though `.new` is also specified).
    // Instead we can just set the menu item state manually.
    let initial = observable[keyPath: keyPath]
    self.items[initial.rawValue].state = .on
  }


  @objc func updateChoice(_ sender: NSMenuItem) {
    let oldValue = observable[keyPath: keyPath]
    items[oldValue.rawValue].state = .off
    sender.state = .on
    let newValue = ChoiceEnum(rawValue: sender.tag)!
    observable[keyPath: keyPath] = newValue
  }
}


public protocol MenuEnum: DenseEnum {
  var menuTitle: String { get }
}
