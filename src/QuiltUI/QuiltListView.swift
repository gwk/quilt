
// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import AppKit
import Quilt


open class QuiltListView: NSScrollView {

  // MARK: NSView

  override public var isFlipped: Bool { true }

  public required init?(coder: NSCoder) { super.init(coder: coder) }


  // MARK: QuiltListView

  public unowned var source: QuiltListSource! = nil

  public var docView: StyledView { documentView as! StyledView }


  public init(frame: CGRect = .frameInit, name: String? = nil, source: QuiltListSource? = nil) {
    super.init(frame: frame)
    self.source = source ?? (self as? QuiltListSource)
    self.name = name
    documentView = StyledView(frame: frame)
    docView.flex = [.w]
    color = .darkGray
    hasVerticalScroller = true
    autohidesScrollers = true
    contentView.postsBoundsChangedNotifications = true
    _ = noteCenter.observe(contentView, name: NSView.boundsDidChangeNotification) {
      (note) in
      //let view = note.object as! NSClipView
    }
  }


  public func reload() {
    docView.removeAllSubviews()
    var index: Int = 0
    var height: Double = 0
    let width: Double = docView.w
    while true {
      if let (rowView, rowHeight) = source.row(index: index, width: width) {
        rowView.flex = .w
        rowView.y += height
        docView.add(viewOrLayer: rowView)
        index += 1
        height += rowHeight
      } else {
        break
      }
    }
    docView.h = height + source.tailHeight
  }
}


public protocol QuiltListSource: AnyObject {

  var rowCount: Int?  { get } // a value of nil indicates that rows will be produced in a stream until exhausted.

  // This value may underestimate the true row count.
  var approximateRowCount: Int { get }

  // A return value of nil indicates that the source cannot approximate the height; the view will be created immediately.
  func approximateHeightForRow(index: Int) -> Double?

  // A return value of nil indicates that the index is at the end of the row sequence.
  func row(index: Int, width: Double) -> (CRViewOrLayer, rowHeight: Double)?

  var tailHeight: Double { get }
}


public extension QuiltListSource {

  var rowCount: Int? { nil }

  var approximateRowCount: Int { 0 }

  func approximateHeightForRow(index: Int) -> Double? { nil }

  var tailHeight: Double { 0 }
}
