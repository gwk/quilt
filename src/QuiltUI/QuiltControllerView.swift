// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

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
