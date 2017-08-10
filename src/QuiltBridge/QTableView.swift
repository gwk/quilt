// © 2017 George King. All rights reserved.

import AppKit
import Quilt


class QTableView: NSScrollView {

  override public var isFlipped: Bool { return true }

  required init?(coder: NSCoder) { super.init(coder: coder) }

  // MARK: QTableView

  weak var delegate: QTableSource!

  var docView: QView { return documentView as! QView }

  init(frame: NSRect, delegate: QTableSource) {
    self.delegate = delegate
    super.init(frame: frame)
    documentView = QView(frame: frame)
    docView.flex = [.width]
    backgroundColor = .darkGray
    hasVerticalScroller = true
    contentView.postsBoundsChangedNotifications = true
    _ = noteCenter.observe(contentView, name: NSView.boundsDidChangeNotification) {
      (note) in
      //let view = note.object as! NSClipView
    }
  }

  func reload() {
    docView.removeAllSubviews()
    var index: Int = 0
    var height: Flt = 0
    let width: Flt = docView.w
    while true {
      if let (rowView, rowHeight) = delegate.row(index: index, width: width) {
        rowView.y += height
        docView.addSubview(rowView)
        index += 1
        height += rowHeight
      } else {
        break
      }
    }
    docView.h = height + delegate.tailHeight
  }
}


protocol QTableSource: class {

  var rowCount: Int?  { get } // a value of nil indicates that rows will be produced in a stream until exhausted.

  // This value may underestimate the true row count.
  var approximateRowCount: Int { get }

  // A return value of nil indicates that the source cannot approximate the height; the view will be created immediately.
  func approximateHeightForRow(index: Int) -> Flt?

  // A return value of nil indicates that the index is at the end of the row sequence.
  func row(index: Int, width: Flt) -> (view: NSView, rowHeight: Flt)?

  var tailHeight: Flt { get }
}


extension QTableSource {

  var rowCount: Int? { return nil }

  var approximateRowCount: Int { return 0 }

  func approximateHeightForRow(index: Int) -> Flt? { return nil }

  var tailHeight: Flt { return 0 }
}
