// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


extension TextOutputStreamable {

  var writtenToString: String {
    var s = ""
    write(to: &s)
    return s
  }
}
