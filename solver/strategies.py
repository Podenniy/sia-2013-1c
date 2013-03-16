
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
        self.data = [initial_board]

    def done(self):
        return not self.data

    def get_next(self):
        item = self._get_next()
        print 'Analyzing %s' % item
        if item.is_empty():
            # TODO: check height
            print 'New solution: %s' % item
            self.solution = item
        return item

    def add_boards(self, boards):
        print 'Adding boards: %s' % '\n'.join([str(board) for board in boards])
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

def solve_with_strategy(board, strategy):

    strategy.initialize(board)

    while not strategy.done():
        to_consider = strategy.get_next()
        new_boards = to_consider.get_new_boards()
        strategy.add_boards(new_boards)

    return strategy.get_result()
