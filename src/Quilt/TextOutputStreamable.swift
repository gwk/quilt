// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


extension TextOutputStreamable {

  var writtenToString: String {
    var s = ""
    write(to: &s)
    return s
  }
}
