// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import SceneKit
import QuiltUI


extension SCNView {

  public class func initOptions(api: SCNRenderingAPI = .metal) -> [String : Any] {
    return [
      SCNView.Option.preferredRenderingAPI.rawValue: NSNumber(value: api.rawValue)
    ]
  }


  public func hitTest(event: CREvent, root: SCNNode, ignoreChildren: Bool, sorted: Bool = true) -> [SCNHitTestResult] {

    let p = self.convert(event.locationInWindow, from: nil)
    return hitTest(p, options: [
      .rootNode: root,
      .ignoreChildNodes: ignoreChildren as NSNumber,
      .sortResults: sorted as NSNumber
    ])
  }
}
