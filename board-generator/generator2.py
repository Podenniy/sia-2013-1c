import random
import collections


class Position(object):

    LIM_X = 12
    LIM_Y = 12

    DELTAS = [(-1, 0), (0, -1), (1, 0), (0, 1)]

    def __init__(self, x, y):
        self.x = x
        self.y = y

    def _add(self, delta):
        return Position(self.x + delta[0], self.y + delta[1])

    def inside_board(self):
        return 0 <= self.x < self.LIM_X and 0 <= self.y < self.LIM_Y

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

KINDS = [i for i in xrange(36)] * 2

def main():

    initial_position = Position(6, 6)
    queue = collections.deque([initial_position])
    seen = collections.deque([initial_position])
    positions = [[0 for _ in range(12)] for __ in range(12)]

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

    print '12'
    print '\n'.join(' '.join(map(str, line)) for line in positions)

if __name__ == '__main__':
    main()
