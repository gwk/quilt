// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import AppKit
import Cocoa
import Quilt
import QuiltRandom


let noteCenter = NotificationCenter.default


open class QuiltMacApp<AppDelegate:NSApplicationDelegate>: NSApplication {

  open var appDelegate: AppDelegate {
    get { return delegate as! AppDelegate }
    set { self.delegate = newValue }
  }

  open var pressedKeyCodes: Set<UInt16> = [] // Track the key codes that are currently pressed.


  open func launch(delegate: NSApplicationDelegate) {

    initAppLaunchSysTime() // This allows us to get the timestamp of events relative to app launch.

    var exePath = Path(CommandLine.arguments[0])
    var needsRestart = false
    while isPathLink(exePath) {
      needsRestart = true
      do { exePath = try resolveLink(exePath) }
      catch let e {
        fatalError("ERROR: could not resolve executable symlink:\n  path: \(exePath)\n  error: \(e)")
      }
    }
    if needsRestart {
      let argv = CommandLine.unsafeArgv
      argv.pointee = MutPtr<Int8>(copy: exePath.string.utf8CString) // alter argv[0] to contain the resolved path.
      Darwin.execv(argv.pointee, argv) // restart the process with the new argv.
    }

    setActivationPolicy(NSApplication.ActivationPolicy.regular)
    self.delegate = delegate
    run()
  }


  // MARK: - NSApplication

  override open func sendEvent(_ event: NSEvent) {
    switch event.type {
    case .keyDown:
      // If the command key is being held, do not insert the pressed key code into the set.
      // This prevents the key from triggering changes when a command stroke is issued,
      // and the user lifts the command key before the other key.
      // Note that a repeat for the held down key will be issued shortly afterwards, which we could also screen for here.
      if !event.modifierFlags.contains(.command) {
        pressedKeyCodes.insert(event.keyCode)
      }
    case .keyUp: pressedKeyCodes.remove(event.keyCode)
    default: break
    }
    super.sendEvent(event)
  }
}
