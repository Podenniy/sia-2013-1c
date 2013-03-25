import logging
import time
import sys

from board_generator import generator2
from solver import model
from solver import greedy
from solver import strategies


logger = logging.getLogger('sia')


def get_stats_solving_with_strategy(board, strategy):
    model.number_of_states = 0
    model.number_of_explosions = 0

    start = time.time()
    solution = strategies.solve_with_strategy(board, strategy)
    end = time.time()

    return end-start, solution, model.number_of_states, model.number_of_explosions


def print_stats_for_strategy(name, board, strategy):
    print("\n\t"+name)
    running_time, solution, states, explosions = (
        get_stats_solving_with_strategy(board, strategy))
    print("\t\tRunning time: " + str(running_time))
    print("\t\tGenerated states: " + str(states))
    print("\t\tExpanded nodes: " + str(explosions))
    print("\t\tFrontier nodes: " + str(states-explosions))


if __name__ == '__main__':

    FORMAT = '%(message)s'
    logging.basicConfig(format=FORMAT)
    logger.setLevel(logging.INFO)
    lines, width = map(int, sys.argv[1:3])
    board = model.Board(generator2.get_positions(lines, width))
    print("Solving board: %s" % board)

    for name, strategy in [('DFS', strategies.DFS()),
                           ('BFS', strategies.BFS()),
                           ('Iterative Deepening 3', strategies.IterativeDeepening(3)),
                           ('Iterative Deepening 5', strategies.IterativeDeepening(5)),
                           ('Greedy slim', greedy.Greedy(greedy.slim_heuristic)),
                           ('Greedy fat', greedy.Greedy(greedy.fat_heuristic)),
                           ('A* slim', greedy.AStar(greedy.slim_heuristic)),
                           ('A* fat', greedy.AStar(greedy.fat_heuristic)),
                          ]:
        print_stats_for_strategy(name, board, strategy)

