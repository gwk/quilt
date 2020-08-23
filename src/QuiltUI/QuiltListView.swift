
// © 2017 George King. All rights reserved.

import AppKit
import Quilt


open class QuiltListView: NSScrollView {

  override public var isFlipped: Bool { return true }

  public required init?(coder: NSCoder) { super.init(coder: coder) }

  // MARK: QuiltListView

  public weak var source: QuiltListSource!

  public var docView: QuiltView { return documentView as! QuiltView }


  public init(frame: CGRect = .frameInit, name: String? = nil, source: QuiltListSource? = nil) {
    self.source = source
    super.init(frame: frame)
    self.name = name
    documentView = QuiltView(frame: frame)
    docView.flex = [.w]
    backgroundColor = .darkGray
    hasVerticalScroller = true
    contentView.postsBoundsChangedNotifications = true
    _ = noteCenter.observe(contentView, name: NSView.boundsDidChangeNotification) {
      (note) in
      //let view = note.object as! NSClipView
    }
  }


  public func reload() {
    docView.removeAllSubviews()
    var index: Int = 0
    var height: Flt = 0
    let width: Flt = docView.w
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


public protocol QuiltListSource: class {

  var rowCount: Int?  { get } // a value of nil indicates that rows will be produced in a stream until exhausted.

  // This value may underestimate the true row count.
  var approximateRowCount: Int { get }

  // A return value of nil indicates that the source cannot approximate the height; the view will be created immediately.
  func approximateHeightForRow(index: Int) -> Flt?

  // A return value of nil indicates that the index is at the end of the row sequence.
  func row(index: Int, width: Flt) -> (CRViewOrLayer, rowHeight: Flt)?

  var tailHeight: Flt { get }
}


public extension QuiltListSource {

  var rowCount: Int? { return nil }

  var approximateRowCount: Int { return 0 }

  func approximateHeightForRow(index: Int) -> Flt? { return nil }

  var tailHeight: Flt { return 0 }
}
