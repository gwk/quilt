// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import CoreGraphics
import SceneKit
import Quilt
import QuiltUI
import QuiltSceneKit


extension Mesh {

  public class func triangle() -> Mesh {
    // One-sided triangle in the XY plane, with vertex radius of 1.
    let x: Flt = sqrt(3.0) * 0.5
    let m = Mesh(name: "triangle")

    m.positions = [
      V3(0, -1, 0),
      V3( x, 0.5, 0),
      V3(-x, 0.5, 0)]

    m.triangles = [Tri(0, 1, 2)]

    m.segments = [
      Seg(0, 1),
      Seg(0, 2),
      Seg(1, 2)]

    m.edges = [
      Edge(va: 0, vb: 1, tl: 0, tr: -1),
      Edge(va: 1, vb: 2, tl: 0, tr: -1),
      Edge(va: 2, vb: 0, tl: 0, tr: -1)]

    return m
  }


  public class func quad() -> Mesh {
    // Square in the XY plane, with side length 1.
    let m = Mesh(name: "quad")

    m.positions = [
      V3(-1, -1, 0),
      V3(-1,  1, 0),
      V3( 1, -1, 0),
      V3( 1,  1, 0)]

    m.triangles = [
      Tri(0, 2, 1),
      Tri(1, 2, 3)]

    m.segments = []

    m.edges = [
      Edge(va: 0, vb: 2, tl: 0, tr: -1),
      Edge(va: 2, vb: 3, tl: 1, tr: -1),
      Edge(va: 3, vb: 1, tl: 1, tr: -1),
      Edge(va: 1, vb: 0, tl: 0, tr: -1),
      Edge(va: 2, vb: 1, tl: 0, tr: 1)]

    m.validate()
    return m
  }
}