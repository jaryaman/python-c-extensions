import array

import numpy as np
import sample
from timeit import timeit

a = array.array('d', [1, -3, 4, 7, 2, 0])
b = np.random.uniform(-10, 10, 1_000_000)
c = np.zeros_like(b)

b2 = np.random.uniform(-10, 10, (1_000, 1_000))
c2 = np.zeros_like(b2)

def main():
    sample.clip(a, 1, 4, a)
    print(a)


    sample.clip(b, -5, 5, c)
    sample.clip2d(b2, -5, 5, c2)

    print(min(c), max(c))
    print(np.min(c2), np.max(c2))

    print(timeit('np.clip(b,-5,5,c)','from __main__ import b,c,np',number=1000))
    print(timeit('sample.clip(b,-5,5,c)','from __main__ import b,c,sample', number=1000))


if __name__ == '__main__':
    main()
