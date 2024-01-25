// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import AppKit
import QuiltUI


open class ExplorerView: QuiltListView, QuiltListSource, CommandProvider {

  public let margin: Double = 4
  public let rowHeight: Double = 32

  public required init?(coder: NSCoder) { fatalError() }

  public init() {
    super.init()
    color = CRColor(l: 1/32)
    reload()
  }


  // MARK: CommandProvider

  public var commands: [Command.Type] { [] }


  // MARK: QuiltListSource

  //var rowCount: Int? { 64 }
/*
  func approximateHeightForRow(index: Int) -> Double? {
    if index >= 64 { return nil }
    return 24
  }
*/
  public func row(index: Int, width: Double) -> (CRViewOrLayer, rowHeight: Double)? {
    if index >= 32 { return nil }
    let l = TextView(frame: CGRect(margin, margin, width - margin * 2, rowHeight - margin))
    l.font = CRFont(name: "Menlo", size: 12)!
    l.text = "row \(index)"
    l.textColor = .white
    l.color = CRColor(l: 0.1)
    return (l, rowHeight)
  }

  public var tailHeight: Double { margin }
}
