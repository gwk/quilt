// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

import Quilt
#if os(OSX)
import AppKit
#endif


public class Button: TextView {

  public enum State: Int, DenseEnum {
    case disabled, enabled, pressed

    public static let count: Int = 3
  }


  public var state: State = .enabled {
    didSet { updateStyle() }
  }


  public var styles: DenseEnumArray<State, TextLayerStyle> = [] {
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
    state = .pressed
  }

  override public func mouseUp(with event: NSEvent) {
    if state == .disabled { return }
    state = .enabled
    let loc = event.location(in: self)
    if bounds.contains(loc), let action = action {
      action()
    }
  }
  #endif
}
