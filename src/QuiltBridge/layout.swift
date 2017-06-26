// © 2014 George King. Permission to use this file is granted in license-qk.txt.

#if os(OSX)
  import AppKit
  public typealias LOP = NSLayoutConstraint.Priority
  //let LOPReq = NSLayoutPriorityRequired // TODO: swift 1.1 omits the 'static' storage type, causing linker error.
  public let LOPReq = LOP(1000)
  public let LOPHidgh = LOP(750)
  public let LOPDragThatCanResizeWindow = LOP(510)
  public let LOPWindowSizeStayPut = LOP(500)
  public let LOPDragThatCannotResizeWindow = LOP(490)
  public let LOPLow = LOP(250)
  public let LOPFit = LOP(50)
  #else
  import UIKit
  public typealias LOP = UILayoutPriority
  //let LOPReq = UILayoutPriorityRequired // TODO: swift 1.1 omits the 'static' storage type, causing linker error.
  public let LOPReq = LOP(1000)
  public let LOPHigh = LOP(750)
  public let LOPLow = LOP(250)
  public let LOPFit = LOP(50)
#endif


public struct QKLayoutOperand {
  // a layout operand represents one side of a constraint: a view and an X,Y pair of attributes;
  // many relations will only express an attribute in one dimension.
  public let v: CRView
  public let ax: NSLayoutConstraint.Attribute
  public let ay: NSLayoutConstraint.Attribute

  public var componentCount: Int { return (ax.isSome ? 1 : 0) + (ay.isSome ? 1 : 0) }
}


extension CRView {

  // layout operand properties.

  public var c_l: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .left, ay: .notAnAttribute) }
  public var c_r: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .right, ay: .notAnAttribute) }
  public var c_t: QKLayoutOperand { return QKLayoutOperand(v: self, ax:  .notAnAttribute, ay: .top) }
  public var c_b: QKLayoutOperand { return QKLayoutOperand(v: self, ax:  .notAnAttribute, ay: .bottom) }

  public var c_x: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .centerX, ay: .notAnAttribute) }
  public var c_y: QKLayoutOperand { return QKLayoutOperand(v: self, ax:  .notAnAttribute, ay: .centerY) }

  public var c_lt: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .left, ay: .top) }
  public var c_ly: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .left, ay: .centerY) }
  public var c_lb: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .left, ay: .bottom) }
  public var c_xt: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .centerX, ay: .top) }
  public var c_xy: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .centerX, ay: .centerY) }
  public var c_xb: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .centerX, ay: .bottom) }
  public var c_rt: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .right, ay: .top) }
  public var c_ry: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .right, ay: .centerY) }
  public var c_rb: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .right, ay: .bottom) }

  public var c_lead: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .leading, ay:  .notAnAttribute) }
  public var c_trail: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .trailing, ay: .notAnAttribute) }

  public var c_w: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .width, ay: .notAnAttribute) }
  public var c_h: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .notAnAttribute, ay: .height) }
  public var c_wh: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .width, ay: .height) }

  public var c_base: QKLayoutOperand { return QKLayoutOperand(v: self, ax: .lastBaseline, ay: .notAnAttribute) }

  public var c_usesARMask: Bool {
    // abbreviated, crossplatform property.
    get { return translatesAutoresizingMaskIntoConstraints }
    set { translatesAutoresizingMaskIntoConstraints = newValue }
  }
}


#if os(iOS)
extension UIViewController {
  // expose the layoutGuide properties as UIView instances so that they can be used by QKLayoutOperand;
  // formulating QKLayoutOperand in terms of protocols including UILayoutSupport protocol is not possible in swift 1.1.
  public var c_tg: UIView {
    let a: AnyObject = topLayoutGuide
    let v = a as! UIView // this cast works in ios 8; not guaranteed to work in the future.
    v.name = "tg"
    return v
  }
  public var c_bg: UIView {
    let a: AnyObject = bottomLayoutGuide
    let v = a as! UIView // this cast works in ios 8; not guaranteed to work in the future.
    v.name = "bg"
    return v
  }
}
#endif


public protocol QKLayoutConstraining {
  // protocol implemented for NSLayoutConstraint, String (visual format strings), and QKLayoutRel.
  // allows for constraints and format strings to be specified in the same variadic call;
  // this is syntactically convenient, and also allows for simultaneous activation of all constraints,
  // which is more performant according to the comments around NSLayoutConstraint.activateConstraints.
  func constraintArray(_ views: [CRView], metrics: [String: NSNumber], opts: NSLayoutConstraint.FormatOptions) -> [NSLayoutConstraint]
}


extension NSLayoutConstraint: QKLayoutConstraining {

  public var lv: CRView { return firstItem as! CRView }
  public var la: NSLayoutConstraint.Attribute { return firstAttribute }
  public var rv: CRView? { return secondItem as! CRView? }
  public var ra: NSLayoutConstraint.Attribute { return secondAttribute }

  convenience init(rel: NSLayoutConstraint.Relation, l: QKLayoutOperand, r: QKLayoutOperand?, m: CGPoint, c: CGPoint, p: LOP, useLX: Bool) {
    // convenience constructor for QKLayoutRel; create a constraint from either ax or ay of left side.
    let la = (useLX ? l.ax : l.ay)
    assert(la != .notAnAttribute)
    var rv: CRView? = nil
    var ra = NSLayoutConstraint.Attribute.notAnAttribute
    let sm = useLX ? m.x : m.y
    let sc = useLX ? c.x : c.y
    if let r = r {
      assert(r.componentCount > 0) // ax or ay or both are acceptable.
      rv = r.v
      // choose the axis of r matching axis of l, or if it is not set, fall back on the alternate.
      let useRX = (useLX ? r.ax.isSome : !r.ay.isSome)
      ra = (useRX ? r.ax : r.ay)
    }
    self.init(item: l.v, attribute: la, relatedBy: rel, toItem: rv, attribute: ra, multiplier: sm,  constant: sc)
    priority = p
  }

  public func constraintArray(_ views: [CRView], metrics: [String: NSNumber], opts: NSLayoutConstraint.FormatOptions) -> [NSLayoutConstraint] {
    // this is only useful for passing a manually constructed constraint as an argument to constrain().
    return [self] // ignore all the format-related arguments.
  }

  public class func eq(_ l: QKLayoutOperand, _ r: QKLayoutOperand? = nil, m: Flt = 1, c: Flt = 0, p: LOP = LOPReq) -> NSLayoutConstraint {
    // normally, the global functions below are used to construct one or two constraints at a time.
    // however, in the case where we want a handle on a particlur constraint for subsequent modification (e.g. for animation),
    // then use this function to construct exactly one constraint.
    assert(l.componentCount == 1)
    return NSLayoutConstraint(rel: NSLayoutConstraint.Relation.equal, l: l, r: r, m: CGPoint(m, m), c: CGPoint(c, c), p: p, useLX: l.ax.isSome)
  }
}


extension String: QKLayoutConstraining {

  public func constraintArray(_ views: [CRView], metrics: [String: NSNumber], opts: NSLayoutConstraint.FormatOptions) -> [NSLayoutConstraint] {
    let viewDict = views.mapToDict { ($0.name, $0) }
    #if DEBUG && false // only use the wrapper method for debug.
      // TODO: constraintsAndCatchWithVisualFormat has yet to be ported,
      // because swift package manager requires that .m files live in separate modules,
      // and swift code cannot catch NSException natively.
      let m = NSLayoutConstraint.constraintsAndCatchWithVisualFormat
      #else
      let m = NSLayoutConstraint.constraints(withVisualFormat:options:metrics:views:)
    #endif
    return m(self, opts, metrics, viewDict) as [NSLayoutConstraint]
  }
}


// MARK: layout relations

public struct QKLayoutRel: QKLayoutConstraining {
  // a relation between two operands; this translates into one or two constraints,
  // depending on whether or not the left operand has two attributes.
  // NOTE: combinations with a single attribute on the left and two on the right are considered invalid (X,XY and Y,XY).
  // this is partly a stylistic choice; although the linear relations are themselves commutative,
  // we consider it good style to put a dependent operand on the left hand side;
  // in the case where an XY pair of attributes are related to a single X or Y, the pair must be dependent on the single.
  public let rel: NSLayoutConstraint.Relation
  public let l: QKLayoutOperand
  public let r: QKLayoutOperand?
  public let m: CGPoint
  public let c: CGPoint
  public let p: LOP

  public func constraintArray(_ views: [CRView], metrics: [String: NSNumber], opts: NSLayoutConstraint.FormatOptions) -> [NSLayoutConstraint] {
    // ignores all the format-related arguments and constructs one or two constraints from the operands.
    //var leftCount = 0
    //var rightCount = 0
    var constraints: [NSLayoutConstraint] = []
    assert(l.componentCount > 0)
    if l.componentCount == 1 && r != nil {
      assert(r!.componentCount < 2, "cannot relate a 1D operand on left to a 2D operand on right; if this relation is intentional, swap operands, rearranging m and c accordingly.")
    }
    if l.ax.isSome {
      constraints.append(NSLayoutConstraint(rel: rel, l: l, r: r, m: m, c: c, p: p, useLX: true))
    }
    if l.ay.isSome {
      constraints.append(NSLayoutConstraint(rel: rel, l: l, r: r, m: m, c: c, p: p, useLX: false))
    }
    return constraints
  }
}

public func c_eq(_ l: QKLayoutOperand, _ r: QKLayoutOperand? = nil, m: CGPoint = CGPoint(1, 1), c: CGPoint = CGPoint(0, 0), p: LOP = LOPReq) -> QKLayoutRel {
  // construct an equality relation between two operands with vector m and c.
  return QKLayoutRel(rel: .equal, l: l, r: r, m: m, c: c, p: p)
}

public func c_eq(_ l: QKLayoutOperand, _ r: QKLayoutOperand? = nil, m: Flt, c: Flt = 0, p: LOP = LOPReq) -> QKLayoutRel {
  // construct an equality relation between two operands with scalar m and optional c; m is required to disambiguate from the vector variant.
  return c_eq(l, r, m: CGPoint(m, m), c: CGPoint(c, c), p: p)
}

public func c_eq(_ l: QKLayoutOperand, _ r: QKLayoutOperand? = nil, c: Flt, p: LOP = LOPReq) -> QKLayoutRel {
  // construct an equality relation between two operands with scalar c; this variant is required to disambiguate from the vector variant.
  return c_eq(l, r, m: CGPoint(1, 1), c: CGPoint(c, c), p: p)
}

// TODO: lt, gt, le, ge.


// MARK: constrain variants

public func constrain(_ views: [CRView], metrics: [String: NSNumber] = [:], opts: NSLayoutConstraint.FormatOptions = NSLayoutConstraint.FormatOptions(rawValue: 0), constraints: [QKLayoutConstraining]) {
  // main variant.
  for v in views {
    v.c_usesARMask = false
  }
  var allConstraints: [NSLayoutConstraint] = []
  for c in constraints {
    allConstraints.append(contentsOf: c.constraintArray(views, metrics: metrics, opts: opts))
  }
  #if DEBUG
    NSLayoutConstraint.activateAndCatchConstraints(allConstraints)
    #else
    NSLayoutConstraint.activate(allConstraints)
  #endif
}

public func constrain(_ views: [CRView], metrics: [String: NSNumber] = [:], opts: NSLayoutConstraint.FormatOptions = NSLayoutConstraint.FormatOptions(rawValue: 0), _ constraints: QKLayoutConstraining...) {
  // variadic variant.
  constrain(views, metrics: metrics, opts: opts, constraints: constraints)
}

