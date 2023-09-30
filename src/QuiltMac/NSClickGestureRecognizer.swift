// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import AppKit


extension NSClickGestureRecognizer {

  public var button: Int {
    get {
      let mask = buttonMask
      for i in 0..<64 {
        let bit = i << i
        if (mask & bit) != 0 { return i }
      }
      fatalError("No reasonable button index found for button mask: \(mask).")
    }
    set {
      buttonMask = (1 << newValue)
    }
  }

  public convenience init(button: Int = 0, clicks: Int = 1, delegate: NSGestureRecognizerDelegate? = nil, target: AnyObject? = nil, action: Selector) {
    self.init()
    self.button = button
    self.numberOfClicksRequired = clicks
    self.delegate = delegate
    self.target = target
    self.action = action
  }
}
