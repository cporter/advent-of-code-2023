import sys

def computeP1(ns):
    yield ns
    while not all(0 == n for n in ns):
        ns = [(b-a) for (a, b) in zip(ns, ns[1:])]
        yield ns

def main():
    p1, p2 = 0, 0

    for line in sys.stdin:
        ns = [int(x) for x in line.strip().split()]
        p1s = list(reversed(list(computeP1(ns))))
        p1s[0].insert(0, 0)
        for i in range(1, len(p1s)):
            x = p1s[i][-1] + p1s[i-1][-1]
            p1s[i].append(x)

            y = p1s[i][0] - p1s[i-1][0]
            p1s[i].insert(0, y)

            # print(p1s)


        p1 += p1s[-1][-1]
        p2 += p1s[-1][0]

    print(f"p1: {p1}")
    print(f"p2: {p2}")

if '__main__' == __name__:
    main()