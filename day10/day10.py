from collections import deque
import networkx as nx
import sys

NORTH = (-1, 0)
SOUTH = (1, 0)
EAST = (0, 1)
WEST = (0, -1)

DIRECTION = {
    '|': [NORTH, SOUTH],
    '-': [EAST, WEST],
    'L': [NORTH, EAST],
    'J': [NORTH, WEST],
    '7': [SOUTH, WEST],
    'F': [SOUTH, EAST],
    'S': [NORTH, SOUTH, EAST, WEST]
}

def main():
    lines = [list(x.strip()) for x in sys.stdin]
    g = nx.Graph()
    start = None
    ROWS, COLS = 0, 0
    for r, cols in enumerate(lines):
        ROWS += 1
        COLS = 0
        for c, ch in enumerate(cols):
            COLS += 1
            if '.' != ch:
                g.add_node((r, c), ch = ch)
                if 'S' == ch:
                    start = (r, c)

    for (x, y), attr in g.nodes(data = True):
        ch = attr['ch']
        for dx, dy in DIRECTION[ch]:
            x1, y1 = x + dx, y + dy
            if (x1, y1) in g.nodes:
                for dx1, dy1 in DIRECTION[g.nodes[(x1, y1)]['ch']]:
                    if dx1 == -dx and dy1 == -dy:
                        g.add_edge((x, y), (x1, y1))

    d = { start: 0 }
    seen = set([start])
    for prev, cur in nx.bfs_edges(g, start):
        seen.add(cur)
        d[cur] = 1 + d[prev]

    print(f"p1: {max(d.values())}")

    path = [a for (a, b) in nx.find_cycle(g, start)]
    total = 0
    for i in range(len(path)):
        r0, c0 = path[i]
        r1, c1 = path[(1 + i) % len(path)]
        total += r0 * c1 - r1 * c0

    area = abs(total/2)

    print(f"p2: {int(area-len(path)/2+1)}")


if '__main__' == __name__:
    main()