// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


public typealias Action = () -> ()

public let processorCount = sysconf(_SC_NPROCESSORS_CONF)


public class ActionThread: Thread {

  public let action: Action

  public init(name: String, action: @escaping Action) {
    self.action = action
    super.init()
    self.name = name
  }

  override public func main() {
    action()
  }
}


public func spawnThread(_ name: String, action: @escaping Action) -> ActionThread {
  let thread = ActionThread(name: name, action: action)
  thread.start()
  return thread
}
