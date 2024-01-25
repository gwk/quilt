// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import AppKit
import QuiltUI


open class CommandPalette: StyledView, QuiltListSource {

  let inputField = NSTextField(name: "inputField")
  let resultsView = QuiltListView(name: "resultsView")
  let titlesToCommandsAndProviders: [String: (Command.Type, CommandProvider)]
  let orderedTitles: [String]
  let prevFirstResponder: NSResponder

  var projectView: QuiltProjectView? { superview as? QuiltProjectView }


  public required init?(coder: NSCoder) { fatalError() }


  public init(frame: CGRect, commandProviders: [CommandProvider], prevFirstResponder: NSResponder) {

    titlesToCommandsAndProviders = Dictionary(
      uniqueKeysWithValues: commandProviders.flatMap { provider in
        provider.commands.map { ($0.title, ($0, provider)) }
      })

    orderedTitles = titlesToCommandsAndProviders.keys.sorted()

    self.prevFirstResponder = prevFirstResponder

    super.init(frame: frame)
    self.flex = .size

    addSubview(inputField)
    inputField.flex = [.horiz]
    //inputField.layerStyle = paletteInputFieldStyle // TODO.
    inputField.color = paletteColor

    addSubview(resultsView)
    resultsView.flex = [.horiz, .b]
    resultsView.source = self
    resultsView.backgroundColor = .clear
    resultsView.drawsBackground = false
    //resultsView.layerStyle = paletteResultsViewStyle // TODO.
    resultsView.docView.layerStyle = paletteResultsDocViewStyle
  }


  override public func layout() {
    super.layout()
    let w = min(512, bounds.w)
    let cx = bounds.c.x

    inputField.w = w
    inputField.h = 24
    inputField.c.x = cx
    inputField.t = 0

    resultsView.w = w
    resultsView.c.x = cx
    resultsView.t = inputField.b + 2 // The gap is covered by the blue focus halo.
    resultsView.h = bounds.h - resultsView.t

    resultsView.reload()
  }


  // MARK: QuiltListSource

  public let rowHeight: Double = 28 + 1


  public func row(index: Int, width: Double) -> (CRViewOrLayer, rowHeight: Double)? {
    if index >= orderedTitles.count { return nil }
    let title = orderedTitles[index]
    let button = Button(frame: CGRect(0, 1, width, rowHeight - 1))
    button.edgeInsets = CREdgeInsets(l: 4, t: 4, r: 4, b: 4)
    button.text = title
    button.styles = [paletteRowStyle, paletteRowStyle, paletteRowStyle, paletteRowStyleLit]
    button.action = {
      [unowned self] in
      projectView?.hideCommandPalette()
      let (commandType, provider) = titlesToCommandsAndProviders[title]!
      let command = commandType.init(provider: provider)
      if command.isReady {
        command.run()
      } else {
        print("command is not ready: \(command)")
      }
    }
    return (button, rowHeight)
  }


  // MARK: - NSResponder

  override public func mouseDown(with event: NSEvent) {
    // Clicked outside of visible palette.
    projectView?.hideCommandPalette()
  }
}


private let paletteColor = CRColor(l: 1/32)


private let paletteRowStyle = TextLayerStyle(
  color: CRColor(l: 0.1), font: .systemFont(ofSize: 14), textColor: .white)

private let paletteRowStyleLit = TextLayerStyle(
  color: CRColor(l: 0.2), textColor: .white)

private let paletteInputFieldStyle = LayerStyle()

private let paletteResultsDocViewStyle = LayerStyle(
  color: .black,
  cornerRadius: 4,
  cornerMask: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner],
  borderColor: .black,
  borderWidth: 1)
