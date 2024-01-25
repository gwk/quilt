// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


public protocol CommandProvider: AnyObject {

  var commands: [Command.Type] { get }
}
