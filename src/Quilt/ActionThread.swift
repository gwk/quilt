// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public let processorCount = sysconf(_SC_NPROCESSORS_CONF)


public class ActionThread: Thread {

  public let action: Action

  public init(name: String, action: @escaping Action) {
    self.action = action
    super.init()
    self.name = name
  }

  public override func main() {
    action()
  }
}


public func spawnThread(_ name: String, action: @escaping Action) -> ActionThread {
  let thread = ActionThread(name: name, action: action)
  thread.start()
  return thread
}
