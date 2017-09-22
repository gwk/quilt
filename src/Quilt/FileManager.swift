// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public let fileManager = FileManager.default


public func currentDir() -> String { return fileManager.currentDirectoryPath }

public func absolutePath(_ path: String) -> String? {
  let cr = fileManager.fileSystemRepresentation(withPath: path)
  let ca = realpath(cr, nil)
  if ca == nil {
    return nil
  }
  let a = fileManager.string(withFileSystemRepresentation: ca!, length: Int(strlen(ca)))
  free(ca)
  return a
}

public func isPathFileOrDir(_ path: String) -> Bool {
  return fileManager.fileExists(atPath: path)
}

public func isPathFile(_ path: String) -> Bool {
  var isDir: ObjCBool = false
  let exists = fileManager.fileExists(atPath: path, isDirectory: &isDir)
  return exists && !isDir.boolValue
}

public func isPathDir(_ path: String) -> Bool {
  var isDir: ObjCBool = false
  let exists = fileManager.fileExists(atPath: path, isDirectory: &isDir)
  return exists && isDir.boolValue
}

public func isPathLink(_ path: String) -> Bool {
  do {
    let attrs = try fileManager.attributesOfItem(atPath: path)
    return (attrs[FileAttributeKey.type]! as! FileAttributeType) == FileAttributeType.typeSymbolicLink
  } catch {
    return false
  }
}

public func resolveLink(_ path: String) throws -> String {
  return try fileManager.destinationOfSymbolicLink(atPath: path)
}

public func removeFileOrDir(_ path: String) throws {
  try fileManager.removeItem(atPath: path)
}

public func createDir(_ path: String, intermediates: Bool = false) throws {
  try fileManager.createDirectory(atPath: path,
    withIntermediateDirectories: intermediates,
    attributes: nil)
}

public func listDir(_ path: String) throws -> [String] {
  return try fileManager.contentsOfDirectory(atPath: path)
}

public func walkPaths(root: String) throws -> [String] {
  if isPathLink(root) { // contrary to documentation, method does not follow symlinks.
    return try walkPaths(root: try resolveLink(root))
  }
  if isPathFile(root) {
    return [root]
  }
  var paths: [String] = []
  for subpath in try fileManager.subpathsOfDirectory(atPath: root) {
    let path = "\(root)/\(subpath)"
    if isPathLink(path) {
      paths.append(contentsOf: try walkPaths(root: resolveLink(path)))
    } else {
      paths.append(path)
    }
  }
  return paths
}

public func walkPaths(roots: [String]) throws -> [String] {
  var paths: [String] = []
  for root in roots {
    try paths.append(contentsOf: walkPaths(root: root))
  }
  return paths
}
