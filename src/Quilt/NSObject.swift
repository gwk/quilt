// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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
