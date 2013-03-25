# ?
import logging
import model

from strategies import BaseStrategy


logger = logging.getLogger('sia')


class NthDimPriorityQueue(object):

    def __init__(self, priority_caps, inner_data_structures):
        priority_cap = priority_caps.pop(0)
        inner = inner_data_structures.pop(0)
        self.priority_cap = priority_cap
        self.minimum = 0
        self.element_count = 0
        self.priorities = [inner(priority_caps[:], inner_data_structures[:])
                           for _ in xrange(priority_cap)]

    def insert(self, priorities, element):
        priority = priorities.pop(0)
        self.minimum = min(self.minimum, priority)
        self.element_count += 1
        self.priorities[priority].insert(priorities, element)

    def get_first(self):
        for priority in xrange(self.minimum, self.priority_cap):
            if self.priorities[priority]:
                self.minimum = priority
                self.element_count -= 1
                return self.priorities[priority].get_first()
        return None

    def __len__(self):
        return self.element_count


class LastLevelQueue(object):

    def __init__(self, priority_cap, unused_inner_data_structure):
        self.data = []

    def insert(self, unused_priorities, element):
        self.data.append(element)

    def get_first(self):
        return self.data.pop()

    def __len__(self):
        return len(self.data)

def choose(n, k):
    """
    A fast way to calculate binomial coefficients by Andrew Dalke (contrib).
    """
    if 0 <= k <= n:
        ntok = 1
        ktok = 1
        for t in xrange(1, min(k, n - k) + 1):
            ntok *= n
            ktok *= t
            n -= 1
        return ntok // ktok
    else:
        return 0

def slim_heuristic(state):
    board = state.board
    states_left = board.tiles_left()

    combinations = [choose(n, 2) for n in board.get_border_sets() if n > 1]
    if combinations:
        right_hand_thingy = reduce(int.__mul__, combinations)
        return min(states_left, right_hand_thingy)
    else:
        return states_left

def fat_heuristic(state):
    board = state.board
    removable_tiles = sum(n for n in board.get_border_sets() if n > 1)
    return board.tiles_left() - removable_tiles

def trivial_heuristic(state):
    return state.board.tiles_left()

class InformedSearch(BaseStrategy):

    def __init__(self, cost_function, heuristic_function):
        self.cost = cost_function
        self.heuristic = heuristic_function

        self.data = NthDimPriorityQueue([150, 150],
                [NthDimPriorityQueue, LastLevelQueue])

    def initialize(self, initial_board):
        self.solution = None
        self.add_boards([model.State(initial_board, 0, None)])

    def add_boards(self, boards):
        for new_state in boards:
            h = self.heuristic(new_state)
            new_state.h = h
            self.data.insert([self.cost(new_state) + h, h], new_state)

    def _get_next(self):
        return self.data.get_first()

class Greedy(InformedSearch):

    def __init__(self, heuristic_function):
        super(Greedy, self).__init__(lambda a: 0, heuristic_function)

def cost_function(state):
    return 2 * state.depth

class AStar(InformedSearch):

    def __init__(self, heuristic_function):
        super(AStar, self).__init__(cost_function, heuristic_function)
