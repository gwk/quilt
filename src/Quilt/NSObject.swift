// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension NSObject {

  public class var dynamicClassFullName: String { return NSStringFromClass(self) }
  
  public class var dynamicClassName: String {
    return NSString(string: dynamicClassFullName).pathExtension // TODO: implement pathExtension for String.
  }
  
  public var typeFullName: String { return NSStringFromClass(type(of: self)) }

  public var typeName: String {
    return NSString(string: typeFullName).pathExtension // TODO: implement pathExtension for String.
  }
}
