import collections
import random
import sys


lines = 12
width = 12

class Position(object):

    DELTAS = [(-1, 0), (0, -1), (1, 0), (0, 1)]

    def __init__(self, x, y):
        self.x = x
        self.y = y

    def _add(self, delta):
        return Position(self.x + delta[0], self.y + delta[1])

    def inside_board(self):
        return 0 <= self.x < lines and 0 <= self.y < width

    def neighbors(self):
        return [
            neighbor
            for neighbor in [self._add(delta) for delta in self.DELTAS]
            if neighbor.inside_board()
        ]

    def randomly_sorted_neighbors(self):
        neighbors = self.neighbors()
        random.shuffle(neighbors)
        return neighbors

    def __eq__(self, other):
        return hasattr(other, 'x') and hasattr(other, 'y') and \
               other.x == self.x and other.y == self.y

KINDS = []

def main():

    initials = []
    for i in lines:
        initial.append(Position(i, width/2))
    queue = collections.deque(initials)
    seen = collections.deque(initials)
    positions = [[0 for _ in range(width)] for __ in range(lines)]

    while queue:
        top = queue.popleft()
        news = [neighbor for neighbor in top.randomly_sorted_neighbors()
                if neighbor not in seen]
        seen.extend(news)
        queue.extend(news)

    random.shuffle(KINDS)

    for kind in KINDS:
        pos1, pos2 = seen.popleft(), seen.popleft()
        positions[pos1.x][pos1.y] = kind
        positions[pos2.x][pos2.y] = kind

    print lines
    print '\n'.join(' '.join(map(str, line)) for line in positions)

if __name__ == '__main__':
    sys.argv.pop(0)
    if sys.argv:
        lines = int(sys.argv.pop(0))
    if sys.argv:
        width = int(sys.argv.pop(0))
    KINDS = [i for i in xrange(lines * width / 4)] * 2
    main()
