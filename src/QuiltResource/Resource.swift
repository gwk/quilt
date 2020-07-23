// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import Quilt
import QuiltDispatch


public protocol Reloadable {
  init()
  mutating func reload(_ file: File) -> Bool
}


public class Resource<T: Reloadable> {
  // A Resource is an encapsulated object that can be reloaded from a file asset.
  // When the file changes the Resource calls reload to update the object.
  // It is intended as a means of speeding up the development cycle.
  // Note that this mechanism requires some sort of mutation of the object.

  public let resPath: Path
  public let path: Path
  public private(set) var obj: T
  private var file: File? = nil
  private var source: DispatchSource? = nil

  deinit {
    cancelSource()
  }

  public init(resPath: Path) {
    self.resPath = resPath
    self.path = pathForResource(resPath)
    self.obj = T()
    retry()
  }

  public func cancelSource() {
    source?.cancel()
    source = nil
  }

  public func reload() {
    if !self.obj.reload(self.file!) {
      errL("resource reload failed: \(self.resPath)")
    }
  }

  public func retry() {
    do {
      file = try File(path: path)
      errL("resource file opened: \(resPath)")
      reload()
      enqueue()
    } catch let e {
      errL("resource file unavailable: \(resPath); error: \(e)")
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.fromNow(1)) {
        [weak self] in
        self?.retry()
      }
    }
  }

  public func handleEvent() {
    let modes = DispatchSource.FileSystemEvent(rawValue: source!.data)
    if modes.contains(.delete) || modes.contains(.rename) || modes.contains(.revoke) {
      errL("resource removed (\(modes)): \(resPath)")
      cancelSource()
      return
    }
    assert(modes == .write, "unexpected modes: \(modes)")
    errL("resource modified: \(resPath)")
    if !file!.rewindMaybe() {
      errL("resource rewind failed: \(resPath)")
      cancelSource()
      return
    }
    reload()
  }

  public func handleCancel() {
    errL("resource dispatch source canceled: \(resPath)")
    file = nil
    retry()
  }

  public func enqueue() {
    let cancelFn: Action = { [weak self] in self?.handleCancel() }
    let eventFn: Action = { [weak self] in self?.handleEvent() }
    source = file!.createDispatchSource([.delete, .rename, .revoke, .write], cancelFn: cancelFn, eventFn: eventFn)
    source!.resume()
  }
}

