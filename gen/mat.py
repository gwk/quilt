#!/usr/bin/env python3
# © 2015 George King. Permission to use this file is granted in license-quilt.txt.

from gen_util import *


def gen_mat(dim, t):
  def isLast(i): return i == dim - 1
  def areLast(i, j): return isLast(i) and isLast(j)
  def commaUnlessIsLast(i): return '' if isLast(i) else ','
  def commaUnlessAreLast(i, j): return '' if areLast(i, j) else ','

  vt = fmt('V$$', dim, t.suffix)
  mt = fmt('M$$', dim, t.suffix)
  rng = range(dim)
  rng_sqr = tuple(product(rng, rng))

  v_comps = all_v_comps[:dim]
  v_comps_a = tuple('a.' + c for c in v_comps)
  v_comps_b = tuple('b.' + c for c in v_comps)
  v_comps_ab = tuple(zip(v_comps_a, v_comps_b))

  els = tuple(fmt('self[$, $]', i, j) for i, j in rng_sqr)
  els_l = tuple('l.' + c for c in els)
  els_r = tuple('r.' + c for c in els)
  els_lr = tuple(zip(els_l, els_r))

  if   t.scalar == 'F32': simd = 'float'
  elif t.scalar == 'F64': simd = 'double'
  else: raise NotImplementedError
  outL('public typealias $ = $$x$', mt, simd, dim, dim)
  outL('')

  outL('extension $ {', mt)

  for i in rng:
    outL('  public var c$: $ { self[$] }', i, vt, i)
  for j in rng:
    outL('  public var r$: $ { $($) }', j, vt, vt, jc(fmt('self[$, $]', i, j) for i in rng))

  outL('  public static let zero = $(0)', mt)
  outL('  public static let ident = $(1)', mt)

  scale_pars = jc(fmt('$: $', c, t.scalar) for c in v_comps)
  scale_args = jc(c for c in v_comps)
  outL('  public static func scale($) -> $ { $(diagonal: $($)) }\n', scale_pars, mt, mt, vt, scale_args)

  if dim >= 3:
    for k, ck in enumerate(v_comps[:3]): # k is index of rotation axis.
      outL('  public static func rot$(_ theta: $) -> $ { $([', ck.upper(), t.scalar, mt, mt)
      for j, cj in enumerate(v_comps):
        def rot_comp(i, ci):
          if i == k or j == k or i == 3 or j == 3:
            return '1' if i == j else '0'
          if i == j:
            return 'cos(theta)'
          # pick the sign of the sin term by hand, based on row j.
          # i would love to find a more conceptually meaningful way of choosing the sign.
          if k == 0:   isNegSinTerm = (j == 2)
          elif k == 1: isNegSinTerm = (j == 0)
          elif k == 2: isNegSinTerm = (j == 1)
          else: assert False
          return fmt('$sin(theta)', '-' if isNegSinTerm else '')
        outL('    $($)$',
          vt,
          jc(rot_comp(i, ci).rjust(11) for i, ci in enumerate(v_comps)),
          ',' if j < dim - 1 else '')
      outL('  ])}\n')

    outL('  public static func rot(theta: $, norm: $) -> $ {', t.scalar, vt, mt)
    outL('    if !theta.isNormal { return ident }')
    outL('    let _cos = cos(theta)')
    outL('    let _cosp = 1 - _cos')
    outL('    let _sin = sin(theta)')
    outL('    return $([', mt)

    rot_terms = [
      [ '_cos + _cosp * norm.x * norm.x',
        '_cosp * norm.x * norm.y + norm.z * _sin',
        '_cosp * norm.x * norm.z - norm.y * _sin',
        '0'],

      [ '_cosp * norm.x * norm.y - norm.z * _sin',
        '_cos + _cosp * norm.y * norm.y',
        '_cosp * norm.y * norm.z + norm.x * _sin',
        '0'],

      [ '_cosp * norm.x * norm.z + norm.y * _sin',
        '_cosp * norm.y * norm.z - norm.x * _sin',
        '_cos + _cosp * norm.z * norm.z',
        '0'],

      ['0', '0', '0', '1']
    ]

    for i in rng:
      outL('      $($)$', vt, jc(rot_terms[i][j] for j in rng), commaUnlessIsLast(i))
    outL('  ])}\n')

    outL('  public static func rot(a: $, _ b: $) -> $ {', vt, vt, mt)
    outL('    return rot(theta: $(a.angle(b)), norm: a.cross(b).norm)', t.scalar)
    outL('  }\n')

  outL('}\n')


if __name__ == '__main__':

  outL('''\
// © 2015 George King. Permission to use this file is granted in license-quilt.txt.
// This file is generated by gen/mat.py.

import simd
import simd.matrix
import QuiltArithmetic

''')

  for d in dims:
    for t in types:
      if not t.simd: continue
      gen_mat(d, t)

