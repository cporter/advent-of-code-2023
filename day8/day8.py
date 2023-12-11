import re
import sys
import numpy

LINEPAT = re.compile('(...) = \((...), (...)\)')

def repeater(xs):
    while True:
        for x in xs:
            yield x

def main():
    stdin = sys.stdin
    lines = [x.strip() for x in sys.stdin]
    dirs = lines[0]
    lines = lines[2:]
    dirs = dirs.strip()

    whut = {}

    for line in lines:
        m = LINEPAT.match(line.strip())
        whut[m[1]] = (m[2], m[3])

    x = 'AAA'
    p1 = 0
    for ch in repeater(dirs):
        p1 += 1
        a, b = whut[x]
        if 'L' == ch:
            x = a
        else:
            x = b
        if 'ZZZ'  == x:
            break

    p2 = 0
    xs = list(k for k in whut.keys() if k.endswith('A'))

    lcm = [-1 for _ in xs]

    for step, ch in enumerate(repeater(dirs), 1):
        p2 += 1
        if 'L' == ch:
            xs = list(whut[x][0] for x in xs)
        else:
            xs = list(whut[x][1] for x in xs)

        for i, x in enumerate(xs):
            if -1 == lcm[i] and x.endswith('Z'):
                lcm[i] = step
        if not any(-1 == x for x in lcm):
            break
        

    print(f"p1: {p1}")
    print(f"p2: {numpy.lcm.reduce(lcm)}")

if '__main__' == __name__:
    main()