// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import AppKit
import Quilt


extension NSView {

  public func showAlert(
    _ message: String,
    info: String? = nil,
    error: Error? = nil,
    modalResponseHandler: ((NSApplication.ModalResponse) -> Void)? = nil) {

    let alert = apply(NSAlert()) {
      $0.messageText = message
      var info = info ?? ""
      if let error = error {
        if !info.isEmpty { info.append("\n") }
        info.append("Error: \(error.localizedDescription)")
      }
      $0.informativeText = info
      $0.addButton(withTitle: "OK")
    }
    if let window = self.window {
      alert.beginSheetModal(for: window, completionHandler: modalResponseHandler)
    } else {
      let response = alert.runModal()
      if let handler = modalResponseHandler {
        handler(response)
      }
    }
  }
}
