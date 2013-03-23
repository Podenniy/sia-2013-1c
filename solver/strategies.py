# ?
import model


def is_solution(board):
    return board.is_empty()

class Strategy(object):

    def initialize(self):
        raise NotImplemented

    def done(self):
        raise NotImplemented

    def get_next(self):
        raise NotImplemented

    def add_boards(self):
        raise NotImplemented

class BaseStrategy(Strategy):

    def initialize(self, initial_board):
        self.solution = None
        self.data = [model.State(initial_board, 0, None)]

    def done(self):
        """Since Mahjong has a fixed depth, we'll stop with the first solution
        we find in both BFS (this is always the case, no matter what the
        problem is) and DFS."""
        return self.solution is not None

    def get_next(self):
        item = self._get_next()
        if not item:
            print 'No items left, no solution was found'
            return None
        print 'Analyzing %s' % item
        if item.is_empty():
            self.set_solution(item)
        return item

    def set_solution(self, item):
        self.solution = item

    def add_boards(self, boards):
        self.data.extend(boards)

    def get_result(self):
        if hasattr(self, 'solution'):
            return self.solution
        return 'No Solution'

class BFS(BaseStrategy):

    def _get_next(self):
        return self.data.pop(0)

class DFS(BaseStrategy):

    def _get_next(self):
        return self.data.pop()

class IterativeDeepening(BaseStrategy):

    def __init__(self, depth):
        self.depth = depth
        self.target_depth = depth
        self.secondary_data = []
        self.use_dfs_strategy = True

    def _get_next(self):
        if not self.data:
            print "No states found in primary stack/queue, swapping."
            self.data = self.secondary_data
            self.secondary_data = []
            self.target_depth += self.depth
            self.use_dfs_strategy = not self.use_dfs_strategy
            if not self.data:
                return None

        return self.data.pop() if self.use_dfs_strategy else self.data.pop(0)

    def add_boards(self, boards):
        for board in boards:
            if board.depth >= self.target_depth:
                print "Add %s to secondary queue/stack" % board
                self.secondary_data.append(board)
            else:
                print "Add %s to primary queue/stack" % board
                self.data.append(board)


def solve_with_strategy(board, strategy):

    strategy.initialize(board)

    while not strategy.done():
        to_consider = strategy.get_next()
        if not to_consider:
            break
        new_boards = to_consider.get_new_boards()
        strategy.add_boards(new_boards)

    return strategy.get_result()
