import collections
import random
import sys


class Position(object):

    DELTAS = [(0, -1), (0, 1)]

    def __init__(self, x, y, lines, width):
        self.x = x
        self.y = y
        self.lines = lines
        self.width = width

    def _add(self, delta):
        return Position(self.x + delta[0], self.y + delta[1],
                        self.lines, self.width)

    def inside_board(self):
        return 0 <= self.x < self.lines and 0 <= self.y < self.width

    def neighbors(self):
        return [
            neighbor
            for neighbor in [self._add(delta) for delta in self.DELTAS]
            if neighbor.inside_board()
        ]

    def __eq__(self, other):
        return hasattr(other, 'x') and hasattr(other, 'y') and \
               other.x == self.x and other.y == self.y


def get_positions(lines, width):

    kinds = [i for i in range(int(lines * width / 4))] * 2
    initials = []
    for i in range(lines):
        initials.append(Position(i, int(width/2), lines, width))
    queue = collections.deque(initials)
    seen = collections.deque(initials)
    positions = [[0 for _ in range(width)] for __ in range(lines)]

    while queue:
        top = queue.popleft()
        news = [neighbor for neighbor in top.neighbors()
                if neighbor not in seen]
        seen.extend(news)
        queue.extend(news)

    random.shuffle(kinds)

    for kind in kinds:
        pos1, pos2 = seen.popleft(), seen.popleft()
        positions[pos1.x][pos1.y] = kind
        positions[pos2.x][pos2.y] = kind

    return positions

def main():
    sys.argv.pop(0)
    lines = 5 
    width = 8
    if sys.argv:
        lines = int(sys.argv.pop(0))
    if sys.argv:
        width = int(sys.argv.pop(0))

    positions = get_positions(lines, width)
    print(lines)
    print('\n'.join(' '.join(map(str, line)) for line in positions))

if __name__ == '__main__':
    main()
