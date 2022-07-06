"""




"""

import ctypes, ctypes.util
import platform

def main():
    if platform.system() == 'Windows':
        _mod = ctypes.WinDLL('./sample.dll')
    elif platform.system() == 'Linux':
        _mod = ctypes.cdll.LoadLibrary('./sample.so')
    else:
        raise OSError(f'OS {platform.system()} not supported')

    # int gcd(int, int)
    gcd = _mod.gcd
    gcd.argtypes = (ctypes.c_int, ctypes.c_int)
    gcd.restype = ctypes.c_int

    # int in_mandel(double, double, int)
    in_mandel = _mod.in_mandel

if __name__ == "__main__":
    main()