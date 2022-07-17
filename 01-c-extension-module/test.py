import sample
import numpy as np
import array

def main():
    print(sample.gcd(35, 42))
    print(sample.in_mandel(0, 0, 500))
    print(sample.in_mandel(2.0, 1.0, 500))
    print(sample.divide(42, 8))
    print(sample.multiply(6, 7))
    print(sample.avg(np.array([4.1, 4.2, 4.3])))
    print(sample.avg(array.array('d', [6.65, 6.66, 6.67])))


if __name__ == '__main__':
    main()
