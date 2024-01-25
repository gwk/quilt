// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import AppKit
import SceneKit
import Quilt
import QuiltUI


open class ContentView: StyledView, CommandProvider {

  @objc dynamic public var title: String = "Untitled"
  public var path: Path? = nil

  open var commands: [Command.Type] { [] }

  open var menus: [NSMenu] { [] }
}
