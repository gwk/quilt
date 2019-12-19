// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import SceneKit


extension SCNNode {

  public convenience init(name: String?) {
    self.init()
    self.name = name
  }
}
