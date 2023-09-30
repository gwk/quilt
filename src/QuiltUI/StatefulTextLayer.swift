// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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
open class StatefulTextLayer<State: DenseEnum>: TextLayer {

  public var state: State = State(rawValue: 0)! {
    didSet { updateStyle() }
  }

  public var styles: CaseArray<State, LayerStyle> = [] {
    didSet { updateStyle() }
  }

  private func updateStyle() {
    layerStyle = styles[state]
    setNeedsDisplay()
  }
}
