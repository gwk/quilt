// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


protocol TextTreeStreamable {
  var textTreeHead: String { get }
  var textTreeChildren: [Any] { get }
}


extension TextOutputStream {

  mutating func writeTextTree(_ val: Any, depth: Int = 0) {
    if depth > 0 { write(String(indent: depth)) }
    if let val = val as? TextTreeStreamable {
      write(val.textTreeHead)
      let children = val.textTreeChildren
      if children.isEmpty { return }
      let childDepth = depth < 0 ? depth : depth + 1
      write("(")
      let childSep = depth < 0 ? " " : "\n" + String(indent: childDepth)
      for child in val.textTreeChildren {
        write(childSep)
        writeTextTree(child, depth: childDepth)
      }
      write(")")
    } else if let val = val as? TextOutputStreamable {
      write(val)
    } else {
      write(String(describing: val))
    }
  }
}
