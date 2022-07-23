import sample
import array

def main():
    print(sample.gcd(42, 10))
    print(sample.in_mandel(1, 1, 400))
    print(sample.in_mandel(0, 0, 400))
    print(sample.divide(42, 10))

    a = array.array('d', [1,2,3])
    print(sample.avg(a))

    p1 = sample.Point(2,3)
    p2 = sample.Point(4,5)

    print(sample.distance(p1, p2))

if __name__ == '__main__':
    main()