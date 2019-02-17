# © 2015 George King. Permission to use this file is granted in license-quilt.txt.

from sys import stderr
from itertools import zip_longest, product
from typing import NamedTuple, Optional


dims = [2, 3, 4]
all_v_comps = ['x', 'y', 'z', 'w']
ops = ['+', '-', '*', '/']


class GenType(NamedTuple):
  scalar:str # Scalar type.
  suffix:str
  f_suffix:str # Float scalar type suffix.
  simd:bool
  is_novel:bool #
  req_codable:bool

types = [
  GenType(scalar='F32', suffix='S',  f_suffix='S', simd=True, is_novel=False, req_codable=False),
  GenType(scalar='F64', suffix='D',  f_suffix='D', simd=True, is_novel=False, req_codable=False),
  GenType(scalar='Int', suffix='I',  f_suffix='D', simd=None, is_novel=True,  req_codable=True),
  GenType(scalar='U8',  suffix='U8', f_suffix='S', simd=None, is_novel=True,  req_codable=True),
]


def fmt(f, *items):
  res = []
  chunks = f.split('$')
  for chunk, item in zip_longest(chunks, items, fillvalue=''):
    res.append(chunk)
    res.append(str(item))
  return ''.join(res)

def outL(f='', *items):
  print(fmt(f, *items))

def errL(f='', *items):
  print(fmt(f, *items), file=stderr)

def je(a): return ''.join(a) # join with empty string.
def jc(a): return ', '.join(a) # join with comma.
def js(a): return ' '.join(a) # join with space.

def jf(j, f, a): return j.join(fmt(f, e) for e in a) # format each element of a sequence.
#def jft(j, f, a): return j.join(fmt(f, *t) for t in a) # format each tuple of a sequence.

def jfra(j, f, comps):
  'Join, right associative.'
  l, *r = comps
  fl = fmt(f, l)
  if not r: return fl
  return f'{fl}{j}({jfra(j,f,r)})'

def jfla(j, f, comps):
  'Join, left associative.'
  res = ''
  for c in comps:
    fc = fmt(f, c)
    if not res:
      res = fc
    else:
      res = f'({res}){j}{fc}'
  return res


def jcf(f, a): return jf(', ', f, a)
#def jcft(f, a): return jft(', ', f, a)

