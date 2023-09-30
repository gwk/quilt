// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

#if os(OSX)
import AppKit
#else
import UIKit
#endif


open class QuiltControllerView<Controller: CRViewController>: StyledView {

  public weak var controller: Controller!

  required public init?(coder: NSCoder) { super.init(coder: coder) }

  public init(name: String, controller: Controller? = nil) {
    super.init(frame: .frameInit)
    self.name = name
    self.controller = controller
  }
}
