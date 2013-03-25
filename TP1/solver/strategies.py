# ?
import collections
import logging
import model


logger = logging.getLogger('sia')


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
        self.data = collections.deque([model.State(initial_board, 0, None)])

    def done(self):
        """Since Mahjong has a fixed depth, we'll stop with the first solution
        we find in both BFS (this is always the case, no matter what the
        problem is) and DFS."""
        return self.solution is not None or self._is_empty()

    def _is_empty(self):
        return not len(self.data)

    def get_next(self):
        item = self._get_next()
        if not item:
            return None
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
        return None

class BFS(BaseStrategy):

    def _get_next(self):
        return self.data.popleft()

class DFS(BaseStrategy):

    def _get_next(self):
        return self.data.pop()

class IterativeDeepening(BaseStrategy):

    def __init__(self, depth):
        self.depth = depth
        self.target_depth = depth
        self.secondary_data = collections.deque()
        self.use_dfs_strategy = True

    def _is_empty(self):
        return not len(self.data) and not len(self.secondary_data)

    def _get_next(self):
        if not self.data:
            self.data = self.secondary_data
            self.secondary_data = collections.deque()
            self.target_depth += self.depth
            self.use_dfs_strategy = not self.use_dfs_strategy
            if not self.data:
                return None

        return self.data.pop() if self.use_dfs_strategy \
                else self.data.popleft()

    def add_boards(self, boards):
        for board in boards:
            if board.depth >= self.target_depth:
                if logger.isEnabledFor('debug'):
                    logger.debug("Add %s to secondary queue/stack", board)
                self.secondary_data.append(board)
            else:
                if logger.isEnabledFor('debug'):
                    logger.debug("Add %s to primary queue/stack", board)
                self.data.append(board)


def solve_with_strategy(board, strategy):

    strategy.initialize(board)
    seen = [set() for _ in xrange(73)]

    while not strategy.done():
        to_consider = strategy.get_next()
        if not to_consider:
            break
        new_boards = to_consider.get_new_boards()
        for board in new_boards:
            if board not in seen[board.depth]:
                seen[board.depth].add(board)
                strategy.add_boards([board])

    result = strategy.get_result()
    path = collections.deque()
    it = result
    while it:
        path.appendleft(it)
        it = it.parent
    logger.debug('\n'.join(map(str, path)))
    return result

