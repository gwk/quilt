// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension Process {

  public static let environment: [String:String] = ProcessInfo.processInfo.environment as [String:String]

  @noreturn
  public static func exit(_ code: Int) { Darwin.exit(Int32(code)) }
}
