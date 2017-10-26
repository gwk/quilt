// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public let fileManager = FileManager.default


public func currentDir() -> Path { return Path(fileManager.currentDirectoryPath) }

public func userHomeDir() -> Path { return Path(fileManager.homeDirectoryForCurrentUser) }

public func userTempDir() -> Path { return Path(fileManager.temporaryDirectory) }

public func expandUser(_ path: Path) -> Path { return Path((path.string as NSString).expandingTildeInPath) }


public func absPath(_ path: Path) -> Path? {
  if path.isAbs { return path }
  if path.isUserAbs {
    if path.string == sysHomePrefix { return userHomeDir() }
    fatalError("absPath: UNIMPLEMENTED")
  }
  let cr = fileManager.fileSystemRepresentation(withPath: path.string)
  let ca = realpath(cr, nil)
  if ca == nil {
    return nil
  }
  let a = fileManager.string(withFileSystemRepresentation: ca!, length: Int(strlen(ca)))
  free(ca)
  return Path(a)
}

public func isPathFileOrDir(_ path: Path) -> Bool {
  return fileManager.fileExists(atPath: path.string)
}

public func isPathFile(_ path: Path) -> Bool {
  var isDir: ObjCBool = false
  let exists = fileManager.fileExists(atPath: path.string, isDirectory: &isDir)
  return exists && !isDir.boolValue
}

public func isPathDir(_ path: Path) -> Bool {
  var isDir: ObjCBool = false
  let exists = fileManager.fileExists(atPath: path.string, isDirectory: &isDir)
  return exists && isDir.boolValue
}

public func isPathLink(_ path: Path) -> Bool {
  do {
    let attrs = try fileManager.attributesOfItem(atPath: path.string)
    return (attrs[FileAttributeKey.type]! as! FileAttributeType) == FileAttributeType.typeSymbolicLink
  } catch {
    return false
  }
}

public func resolveLink(_ path: Path) throws -> Path {
  return try Path(fileManager.destinationOfSymbolicLink(atPath: path.string))
}

public func removeFileOrDir(_ path: Path) throws {
  try fileManager.removeItem(atPath: path.string)
}

public func createDir(_ path: Path, intermediates: Bool = false) throws {
  try fileManager.createDirectory(atPath: path.string,
    withIntermediateDirectories: intermediates,
    attributes: nil)
}

public func listDir(_ path: Path) throws -> [Path] {
  return try fileManager.contentsOfDirectory(atPath: path.string).map { Path($0) }
}

public func walkPaths(root: Path) throws -> [Path] {
  if isPathLink(root) { // contrary to documentation, method does not follow symlinks.
    return try walkPaths(root: try resolveLink(root))
  }
  if isPathFile(root) {
    return [root]
  }
  var paths: [Path] = []
  for subpath in try fileManager.subpathsOfDirectory(atPath: root.string).map({Path($0)}) {
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
