// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Quilt


open class Command {

  public weak var provider: CommandProvider?

  public required init(provider: CommandProvider) {
    self.provider = provider
  }

  open class var title: String { mustOverride() }

  public var isReady: Bool { true }

  open func run() { mustOverride() }
  open func undo() { mustOverride() }
}
