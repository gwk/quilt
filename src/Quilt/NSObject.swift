// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension NSObject {

  public class var dynamicClassFullName: String { NSStringFromClass(self) }

  public class var dynamicClassName: String {
    NSString(string: dynamicClassFullName).pathExtension // TODO: implement pathExtension for String.
  }

  public var typeFullName: String { NSStringFromClass(type(of: self)) }

  public var typeName: String {
    NSString(string: typeFullName).pathExtension // TODO: implement pathExtension for String.
  }
}
