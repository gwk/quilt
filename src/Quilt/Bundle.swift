// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension Bundle {

  public class func resPath(_ name: String) -> String {
    return main.pathForResource(name, ofType: nil)!
  }

  public class func textNamed(_ name: String) throws -> String {
    let p = resPath(name)
    do {
      return try String(contentsOfFile: p, encoding: String.Encoding.utf8)
    } catch let e as NSError {
      print("could not read resource text: \(name) error: \(e)")
      throw e
    }
  }
}
