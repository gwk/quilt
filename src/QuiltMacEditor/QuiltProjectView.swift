// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import AppKit
import SceneKit
import Quilt
import QuiltMac
import QuiltUI


open class QuiltProjectView: StyledView {

  let projectDir: Path?

  let explorerView: ExplorerView

  // The four container views that make up the project window.
  public let leftSideView = StyledView(name: "leftSide")
  public let tabsView = TabsView(name: "tabs")
  let contentContainer = StyledView(name: "contentContainer")
  let trayView = StyledView(name: "tray")

  var commandPalette: CommandPalette?

  var commandProviders: [CommandProvider] {
    return contentViews + [explorerView]
  }

  public var contentViews: [ContentView] {
    tabsView.tabs.map { $0.contentView }
  }

  private(set) var activeContentView: ContentView? = nil {
    didSet {
      oldValue?.removeFromSuperview()
      activeContentMenuItems.forEach { NSApp.mainMenu!.removeItem($0) }
      activeContentMenuItems.removeAll()

      if let contentView = activeContentView {
        contentView.update(frame: contentContainer.bounds, flex: [.w, .h])
        contentContainer.addSubview(contentView)
        window!.makeFirstResponder(contentView)

        for menu in contentView.menus {
          let item = NSApp.mainMenu!.add(submenu: menu)
          activeContentMenuItems.append(item)
        }

        // TODO: update the side views for the new content as necessary.
      }
    }
  }

  private(set) var activeContentMenuItems: [NSMenuItem] = []


  deinit { errL("deinit: \(self)") }


  public required init?(coder: NSCoder) { fatalError() }


  public init(projectDir: Path?) {
    self.projectDir = projectDir
    explorerView = ExplorerView()
    //sceneOutlineView = SceneOutlineView() // TODO

    super.init(frame: .frameInit)

    // layout.
    addSubviews(leftSideView, tabsView, contentContainer, trayView)

    let w: Double = 1024
    let h: Double = 512
    let leftW: Double = 256
    let trayH: Double = 128
    let tabHeight: Double = 24

    update(frame: CGRect(w, h), flex: .size)

    leftSideView.update(frame: CGRect(l:0, r: leftW, t:0, b: h), flex: [.r, .h])
    let l = leftSideView.r + 1
    tabsView.update(frame: CGRect(l:l, r:w, t:0, b:tabHeight), flex: [.w, .b])
    trayView.update(frame: CGRect(l:l, r:w, b:h, h:trayH), flex: [.w, .t])
    contentContainer.update(frame: CGRect(l:l, r:w, t:tabsView.b+1, b:trayView.t-1), flex: .size)

    self.color = .black
    contentContainer.color = .black
    trayView.color = CRColor(r:1/8)

    isLeftSideVisible = true
    isTrayVisible = false

    //leftSideView.addSubview(sceneOutlineView) // TODO
    //sceneOutlineView.update(frame: leftSideView.bounds) // TODO
  }


  public var isLeftSideVisible: Bool {
    get { !leftSideView.isHidden }
    set {
      leftSideView.isHidden = !newValue
      let l, w: Double
      if newValue {
        l = leftSideView.r + 1
        w = self.w - l
      } else {
        l = 0
        w = self.w
      }
      tabsView.l = l
      contentContainer.l = l
      trayView.l = l
      tabsView.w = w
      contentContainer.w = w
      trayView.w = w
    }
  }


  public var isTrayVisible: Bool {
    get { !trayView.isHidden }
    set {
      trayView.isHidden = !newValue
      if newValue {
        contentContainer.h = (trayView.t - 1 - contentContainer.t)
      } else {
        contentContainer.h = self.h - contentContainer.t
      }
    }
  }


  override public var description: String {
    "\(type(of: self))(projectDir:\(projectDir.optDesc))"
  }


  public func open(path: Path) {
    print("TODO: implement open: \(path)")
    //let c = TextEditView() // TODO: decide type of controller based on extension.
    //add(contentView: c)
    //c.open(path: path)
  }


  public func updateAll() { updateTitle() }

  public func updateTitle() { window!.title = projectDir?.string ?? "Pen" }


  // MARK: - Content Views


  public func add(contentView: ContentView) {
    let tab = tabsView.addTab(contentView: contentView)
    onSelect(tab: tab)
  }


  public func onSelect(tab: TabsView.Tab) {
    activeContentView = tab.contentView
  }


  // MARK: - Aux Views

  public func toggleLeftSide() {
    isLeftSideVisible = !isLeftSideVisible
  }


  public func toggleTray() {
    isTrayVisible = !isTrayVisible
  }


  // MARK: - Command Palette

  public func hideCommandPalette() {
    guard let palette = commandPalette else { return }
    palette.removeFromSuperview()
    window?.makeFirstResponder(palette.prevFirstResponder)
    commandPalette = nil
  }

  public func showCommandPalette() {
    let palette = CommandPalette(frame: bounds, commandProviders: commandProviders, prevFirstResponder: window!.firstResponder!)
    commandPalette = palette
    addSubview(palette)
    window?.makeFirstResponder(palette.inputField)
  }

  public func toggleCommandPalette() {
    if commandPalette == nil {
      showCommandPalette()
    } else {
      hideCommandPalette()
    }
  }


  // MARK: - Menu actions

  @objc public func fileClose() {
    guard let contentView = activeContentView else { return }
    let tab = tabsView.tab(for: contentView)
    activeContentView = nil
    tabsView.remove(tab: tab) // Selects the previous tab if it exists.
  }


  // MARK: - NSResponder

  override public var acceptsFirstResponder: Bool { true }

  override public func becomeFirstResponder() -> Bool {
    //errL("becomeFirstResponder: \(self)")
    return true
  }

  override public func resignFirstResponder() -> Bool {
    //errL("resignFirstResponder: \(self)")
    return true
  }


  override public func performKeyEquivalent(with event: NSEvent) -> Bool {
    switch event.modifiersAndKey {
    case (.command, "p"): toggleCommandPalette()
    case ([.command, .shift], "L"): toggleLeftSide()
    case ([.command, .shift], "T"): toggleTray()
    default: return super.performKeyEquivalent(with: event)
    }
    return true
  }
}
