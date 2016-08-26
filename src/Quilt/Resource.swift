// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public protocol Reloadable {
  init()
  mutating func reload(_ file: InFile) -> Bool
}


public let resourceRootDir: String = {
  // TODO: if in release mode or flag not present, return bundle resource directory.
  let key = "RALLY_RESOURCE_DIR"
  if let path = Process.environment[key] {
    errL("resourceRootDir: using environment \(key): \(path)")
    return path
  }
  return Bundle.main.path(forResource: "res", ofType: nil)!
}()


public func pathForResource(_ resPath: String) -> String {
  return "\(resourceRootDir)/\(resPath)"
}


public class Resource<T: Reloadable> {
  // A Resource is an encapsulated object that can be reloaded from a file asset.
  // When the file changes the Resource calls reload to update the object.
  // It is intended as a means of speeding up the development cycle.
  // Note that this mechanism requires some sort of mutation of the object.

  public let resPath: String
  public let path: String
  public private(set) var obj: T
  private var file: InFile? = nil
  private var source: DispatchSource? = nil

  deinit {
    cancelSource()
  }

  public init(resPath: String) {
    let path = pathForResource(resPath)
    self.resPath = resPath
    self.path = path
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
      file = try InFile(path: path)
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

