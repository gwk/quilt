// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Quilt
#if os(OSX)
import AppKit
#endif


open class Button: TextView {

  public enum State: Int, DenseEnum {
    case disabled, dimmed, enabled, pressed
  }


  public var state: State = .enabled {
    didSet { updateStyle() }
  }

  private var wasDimmed: Bool = false

  public var styles: CaseArray<State, TextLayerStyle> = [] {
    didSet { updateStyle() }
  }


  private func updateStyle() {
    self.layerStyle = styles[state]
  }


  public var action: Action? = nil


  // MARK: - NSResponder
  #if os(OSX)

  override public func mouseDown(with event: NSEvent) {
    if state == .disabled { return }
    wasDimmed = (state == .dimmed)
    state = .pressed
  }

  override public func mouseUp(with event: NSEvent) {
    if state == .disabled { return }
    let loc = event.location(in: self)
    if bounds.contains(loc) {
      state = .enabled
      action?()
    } else {
      state = (wasDimmed ? .dimmed : .enabled)
    }
  }
  #endif
}
