// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


public typealias Observer = NSObjectProtocol


public let noteCenter: NotificationCenter = NotificationCenter.default

extension NotificationCenter {

  public func observe(_ object: Any, name: NSNotification.Name, queue: OperationQueue = OperationQueue.main,
                      block: @escaping (Notification)->Void) -> Observer {
    return addObserver(forName: name, object: object, queue: queue, using: block)
  }

  public func observeOnce(_ object: Any, name: NSNotification.Name, queue: OperationQueue = OperationQueue.main,
                          block: @escaping (Notification)->Void) -> Observer {
    let center = self
    var observer: Observer!
    observer = observe(object, name: name, queue: queue) {
      (note) in
      block(note)
      center.removeObserver(observer!)
    }
    return observer
  }
}
