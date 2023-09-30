// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


extension Bundle {

  public class func resPath(_ path: Path) -> Path {
    precondition(path.isRel)
    return Path(main.path(forResource: path.string, ofType: nil)!)
  }

  public class func textNamed(_ path: Path) throws -> String {
    let p = resPath(path)
    do {
      return try File(path: p).readText()
    } catch let e {
      print("could not read resource text: \(path) error: \(e)")
      throw e
    }
  }
}


public let resourceRootDir: Path = {
  // TODO: if in release mode or flag not present, return bundle resource directory.
  let key = "RALLY_RESOURCE_DIR" // TODO: rename to QUILT_RESOURCE_DIR? QUILT_DEV_RESOURCE_DIR?
  if let pathString = processEnvironment[key] {
    errL("resourceRootDir: using environment \(key): \(pathString)")
    return Path(pathString)
  }
  return Path(Bundle.main.path(forResource: "res", ofType: nil)!)
}()


public func pathForResource(_ resPath: Path) -> Path {
  resourceRootDir.cat(resPath)
}
