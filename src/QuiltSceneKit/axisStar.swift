// © 2020 George King. All rights reserved.

import SceneKit
import QuiltVec
import QuiltUI


public enum AxisStarStyle {
  case cylinder
  //case box
  //case cone
  case pyramid
}


public class AxisNode: SCNNode {
  public var axisIndex = 0
}


public func makeAxisStar(name: String, style: AxisStarStyle, scale: Float = 1.0, prongWidth: Double = 0.125, prongHeight: Double = 1.0) -> SCNNode {
  let axisStar = SCNNode(name: name)
  axisStar.simdScale = V3F(scalar: scale)

  func addAxis(axis: Int, rotAxis: Int, rot: Double, _ colorNeg: CRColor, _ colorPos: CRColor) {

    func addProng(sign: Double, color: CRColor) {
      let node = AxisNode(name: "axisStarProng")
      node.axisIndex = axis
      axisStar.add(node)
      let geom: SCNGeometry
      switch style {
      case .cylinder:
        geom = SCNCylinder(radius: prongWidth * 0.5, height: prongHeight)
        node.simdPosition[axis] = Float(sign * prongHeight * 0.5)
      case .pyramid:
        geom = SCNPyramid(width: prongWidth, height: prongHeight, length: prongWidth)
      }
      node.geometry = geom
      geom.materials = [SCNMaterial(flatColor: color)]

      var r = V4F.zero
      r[rotAxis] = 1
      r.w = Float(axis == 1 ? (sign == 1 ? 0 : .pi) : rot * sign)
      node.simdRotation = r
    }

    addProng(sign: -1, color: colorNeg)
    addProng(sign: 1, color: colorPos)
  }

  addAxis(axis: 0, rotAxis: 2, rot: -.pi/2, CRColor(r: 0.4), CRColor(r: 0.8))
  addAxis(axis: 1, rotAxis: 0, rot: 0,      CRColor(g: 0.4), CRColor(g: 0.8))
  addAxis(axis: 2, rotAxis: 0, rot: .pi/2,  CRColor(b: 0.4), CRColor(b: 0.8))
  return axisStar
}
