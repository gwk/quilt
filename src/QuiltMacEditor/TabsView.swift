// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import AppKit
import Quilt
import QuiltDispatch
import QuiltUI


open class TabsView: NSScrollView {

  public class DocView: StyledView {

    override public func layout() {
      super.layout()
      let w = 128.0
      let h = superview!.h
      var x = 1.0
      for view in subviews {
        view.frame = CGRect(x, 1, w, h)
        x = view.r + 1
      }
      self.w = x
    }

    override public func adjustScroll(_ newVisible: CGRect) -> CGRect {
      var rect = newVisible
      rect.y = 0
      return rect
    }
  }


  public class Tab: Button {

    public let contentView: ContentView
    var observation: NSKeyValueObservation? = nil

    public required init?(coder: NSCoder) { fatalError() }

    
    public init(contentView: ContentView) {
      self.contentView = contentView

      super.init(frame: .frameInit)
      styles = tabStyles
      edgeInsets = CREdgeInsets(l: 4, t: 4, r: 4, b: 4)

      observation = contentView.observe(\.title, options: [.initial]) {
        [unowned self] (contentView, change) in
        self.text = contentView.title
      }
    }
  }


  public var docView: DocView { documentView as! DocView }

  public var tabs: LazyMapSequence<[NSView], Tab> { docView.subviews.lazy.map { $0 as! Tab } }


  public var projectView: QuiltProjectView { superview as! QuiltProjectView }

  public var selectedTab: Tab? = nil {
    didSet {
      if let prev = oldValue {
        prev.state = .dimmed
      }
      if let curr = selectedTab {
        curr.state = .enabled
      }
    }
  }


  public required init?(coder: NSCoder) { fatalError() }


  public init(name: String) {
    super.init(frame: .frameInit)
    self.name = name
    flex = [.w, .b]

    documentView = DocView(frame: bounds)
    backgroundColor = .black
    docView.color = .black


  }


  public func addTab(contentView: ContentView) -> Tab {
    let tab = Tab(contentView: contentView)
    docView.addSubview(tab)

    tab.action = {
      [unowned self, tab] in
      self.selectedTab = tab
      self.projectView.onSelect(tab: tab)
    }
    docView.setNeedsLayout()
    selectedTab = tab
    return tab
  }


  public func remove(tab: Tab) {
    let idx = docView.subviews.firstIndex(of: tab)!
    tab.removeFromSuperview()
    if docView.subviews.isEmpty {
      selectedTab = nil
    } else if selectedTab == tab {
      let prevIdx = (idx == 0 ? 0 : idx - 1)
      let prevTab = docView.subviews[prevIdx] as! Tab
      selectedTab = prevTab
      projectView.onSelect(tab: prevTab)
    }
    docView.setNeedsLayout()
  }


  public func tab(for contentView: ContentView) -> Tab {
    for v in docView.subviews {
      let tab = v as! Tab
      if tab.contentView == contentView { return tab }
    }
    fatalError()
  }
}



private let tabStyle = TextLayerStyle(
  cornerRadius: 4,
  cornerMask: [.layerMinXMinYCorner, .layerMaxXMinYCorner],
  font: .systemFont(ofSize: 12),
  textColor: CRColor(l: 0.75))


private let tabStyleDimmed = vary(tabStyle) {
  $0.color = CRColor(l: 0.1)
  $0.textColor = CRColor(l: 0.5)
}


private let tabStyleEnabled = vary(tabStyle) {
  $0.color = CRColor(l: 0.15)
}

private let tabStyleLit = vary(tabStyle) {
  $0.color = CRColor(l: 0.2)
}


private let tabStyles = CaseArray<Button.State, TextLayerStyle>(
  [tabStyleDimmed, tabStyleDimmed, tabStyleEnabled, tabStyleLit])
