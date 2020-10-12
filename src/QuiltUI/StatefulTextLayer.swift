// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

import CoreGraphics
import CoreText
import Foundation
#if os(OSX)
  import AppKit
#else
  import UIKit
#endif

import Quilt


@available(macOS 10.11, *)
public class StatefulTextLayer<State: DenseEnum>: TextLayer {

  public var state: State = State(rawValue: 0)! {
    didSet { updateStyle() }
  }

  public var styles: DenseEnumArray<State, LayerStyle> = [] {
    didSet { updateStyle() }
  }

  private func updateStyle() {
    layerStyle = styles[state]
    setNeedsDisplay()
  }
}
