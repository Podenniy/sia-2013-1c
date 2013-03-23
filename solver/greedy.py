# ?
import model

class NthDimPriorityQueue(object):

    def __init__(self, priority_caps, inner_data_structures):
        priority_cap = priority_caps.pop(0)
        inner = inner_data_structures.pop(0)
        self.priority_cap = priority_cap
        self.minimum = 0
        self.element_count = 0
        self.priorities = [inner(priority_caps, inner_data_structures)
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

    def insert(self, unused_priorities, element)
        self.data.append(element)

    def get_first(self):
        return self.data.pop()

    def __len__(self):
        return len(self.data)


def a_star_solve(board, cost_function, heuristic_function):
    """Solves the board."""
    initial_state = model.State(initial_board, 0, None)
    queue = NthDimPriorityQueue([150, 150],
                                [NthDimPriorityQueue, LastLevelQueue])
    queue.insert([cost_function(initial_state),
                  heuristic_function(initial_state)], initial_state)

    solution = None
    while queue:
        element = queue.get_first()
        if element.is_empty():
            solution = element
            break
        for new_state in element.get_new_boards():
            queue.insert([cost_function(new_state),
                          heuristic_function(new_state)], new_state)

    return solution
