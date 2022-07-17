"""
A module accessing C code in sample.c
"""

import ctypes
import ctypes.util
import platform
from pathlib import Path

here = Path(__file__)

if platform.system() == 'Windows':
    _mod = ctypes.WinDLL(str(here.parent/'sample.dll'))
elif platform.system() == 'Linux':
    _mod = ctypes.cdll.LoadLibrary(str(here.parent/'_sample.so'))
else:
    raise OSError(f'OS {platform.system()} not supported')

# int gcd(int, int)
gcd = _mod.gcd
gcd.argtypes = (ctypes.c_int, ctypes.c_int)
gcd.restype = ctypes.c_int

# int in_mandel(double, double, int)
in_mandel = _mod.in_mandel
in_mandel.argtypes = (ctypes.c_double, ctypes.c_double, ctypes.c_int)
in_mandel.restype = ctypes.c_int

# int divide(int, int, int *)
_divide = _mod.divide
_divide.argtypes = (ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_int))
_divide.restype = ctypes.c_int


def divide(x, y):
    rem = ctypes.c_int()
    quot = _divide(x, y, rem)
    return quot, rem.value


class DoubleArrayType:
    def from_param(self, param):
        type_name = type(param).__name__
        if hasattr(self, 'from_' + type_name):
            return getattr(self, 'from_' + type_name)(param)
        elif isinstance(param, ctypes.Array):
            return param
        else:
            raise TypeError(f"Can't convert {type_name}")

    # Cast from array.array objects
    def from_array(self, param):
        if param.typecode != 'd':
            raise TypeError('Must be an array of doubles')

        ptr, _ = param.buffer_info()
        return ctypes.cast(ptr, ctypes.POINTER(ctypes.c_double))

    # Cast from lists/tuples
    def from_list(self, param):
        val = ((ctypes.c_double) * len(param))(*param)
        return val

    from_tuple = from_list

    # Cast from numpy array
    def from_ndarray(self, param):
        return param.ctypes.data_as(ctypes.POINTER(ctypes.c_double))


DoubleArray = DoubleArrayType()
_avg = _mod.avg
_avg.argtypes = (DoubleArray, ctypes.c_int)
_avg.restype = ctypes.c_double


def avg(values):
    return _avg(values, len(values))


# struct Point { }
class Point(ctypes.Structure):
    _fields_ = [('x', ctypes.c_double),
                ('y', ctypes.c_double)]


# doubel distance(Point *, Point *)
distance = _mod.distance
distance.argtypes = (ctypes.POINTER(Point), ctypes.POINTER(Point))
distance.restype = ctypes.c_double
