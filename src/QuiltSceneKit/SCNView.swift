// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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
