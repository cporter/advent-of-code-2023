import math
import sys

def countem(t, d):
    a = 1
    b = -t
    c = d
    
    x = math.floor((-b - math.sqrt(b * b - 4 * a * c)) / (2 * a))
    y = math.ceil((-b + math.sqrt(b * b - 4 * a * c)) / (2 * a))

    return abs(x - y) - 1
    

def main():
    lines = [x.strip() for x in sys.stdin]
    times = [int(x) for x in lines[0].split(':')[1].strip().split()]
    dists = [int(x) for x in lines[1].split(':')[1].strip().split()]

    p1 = 1
    for (t, d) in zip(times, dists):
        p1 *= countem(t, d)
    
    t = int(''.join([f"{x}" for x in times]))
    d = int(''.join([f"{x}" for x in dists]))

    p2 = countem(t, d)
    
    print(f"p1: {p1}")
    print(f"p2: {p2}")



if '__main__' == __name__:
    main()