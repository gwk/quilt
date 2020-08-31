// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public let fileManager = FileManager.default

public let usersDir = Path(sysHomeDirString)

public let userHomeDirString = NSHomeDirectory() + "/"

public func currentDir() -> Path { Path(fileManager.currentDirectoryPath + "/") }

public func userTempDir() -> Path { Path(fileManager.temporaryDirectory.path + "/") }


public func absPath(_ path: Path) -> Path {
  path.isRel ? currentDir().cat(path) : path
}

public func absPath(_ string: String) -> Path { absPath(Path(string)) }


public func isPathFileOrDir(_ path: Path) -> Bool {
  fileManager.fileExists(atPath: path.expandUser)
}

public func isPathFile(_ path: Path) -> Bool {
  var isDir: ObjCBool = false
  let exists = fileManager.fileExists(atPath: path.expandUser, isDirectory: &isDir)
  return exists && !isDir.boolValue
}

public func isPathDir(_ path: Path) -> Bool {
  var isDir: ObjCBool = false
  let exists = fileManager.fileExists(atPath: path.expandUser, isDirectory: &isDir)
  return exists && isDir.boolValue
}

public func isPathLink(_ path: Path) -> Bool {
  do {
    let attrs = try fileManager.attributesOfItem(atPath: path.expandUser)
    return (attrs[FileAttributeKey.type]! as! FileAttributeType) == FileAttributeType.typeSymbolicLink
  } catch {
    return false
  }
}

public func resolveLink(_ path: Path) throws -> Path {
  try Path(fileManager.destinationOfSymbolicLink(atPath: path.expandUser))
}

public func removeFileOrDir(_ path: Path) throws {
  try fileManager.removeItem(atPath: path.expandUser)
}

public func createDir(_ path: Path, intermediates: Bool = false) throws {
  try fileManager.createDirectory(atPath: path.expandUser,
    withIntermediateDirectories: intermediates,
    attributes: nil)
}

public func listDir(_ path: Path) throws -> [Path] {
  try fileManager.contentsOfDirectory(atPath: path.expandUser).map { Path($0) }
}

public func walkPaths(root: Path) throws -> [Path] {
  if isPathLink(root) { // contrary to documentation, method does not follow symlinks.
    return try walkPaths(root: try resolveLink(root))
  }
  if isPathFile(root) {
    return [root]
  }
  var paths: [Path] = []
  for subpath in try fileManager.subpathsOfDirectory(atPath: root.expandUser).map({Path($0)}) {
    let path = root.cat(subpath)
    if isPathLink(path) {
      paths.append(contentsOf: try walkPaths(root: resolveLink(path)))
    } else {
      paths.append(path)
    }
  }
  return paths
}

public func walkPaths(roots: [Path]) throws -> [Path] {
  var paths: [Path] = []
  for root in roots {
    try paths.append(contentsOf: walkPaths(root: root))
  }
  return paths
}
