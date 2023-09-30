// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Dispatch


extension File {

  public func createDispatchSource(_ modes: DispatchSource.FileSystemEvent, queue: DispatchQueue = DispatchQueue.main,
    registerFn: Action? = nil, cancelFn: Action? = nil, eventFn: @escaping Action) -> DispatchSource {
      let source = DispatchSource.makeFileSystemObjectSource(fileDescriptor: descriptor, eventMask: modes, queue: queue)
      if let rf = registerFn {
        source.setRegistrationHandler(handler: rf)
      }
      // the cancel handler retains the file to prevent a race condition
      // where the file descriptor gets reused but the source is not yet canceled.
      // see the documentation for dispatch_source_set_cancel_handler.
      let _self = self
      if let cf = cancelFn {
        source.setCancelHandler {
          [_self] in
          _ = _self
          cf()
        }
      } else {
        source.setCancelHandler {
          [_self] in
          _ = _self
        }
      }
      source.setEventHandler(handler: eventFn)
      return source as! DispatchSource // TODO: improve signature.
  }
}
