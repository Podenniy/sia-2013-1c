import parser
import strategies
import model
import greedy

from time import time
from sys import argv

available_strategies = {
    'dfs': strategies.DFS,
    'bfs': strategies.BFS,
    'iterative': strategies.IterativeDeepening,
    'A*': greedy.AStar,
    'greedy': greedy.Greedy,
}

needs_heuristics = ['A*', 'greedy']

heuristics = {
    'slim': greedy.slim_heuristic,
    'fat': greedy.fat_heuristic,
}

def usage(msg = ""):
    print(msg)
    print("Usage: " + argv[0] + " board_file_path algorithm [heuristic]")
    print("Valid algoriths: " + ' '.join(available_strategies.keys()))
    print("Valid heuristics: " + ' '.join(heuristics.keys()))
    exit(0)

if len(argv) < 3:
    usage()

argv.pop(0)
board_file_name = argv.pop(0)

strategy_name = argv.pop(0)
if strategy_name not in available_strategies:
    usage("Pick a valid strategy name")

heuristic = None
if strategy_name in needs_heuristics:
    if not len(argv):
        usage(strategy_name + " needs an heuristic")
    heuristic_name = argv.pop(0)
    if heuristic_name not in heuristics:
        usage("Pick a valid heuristic name")
    heuristic = heuristics[heuristic_name]

    strategy = available_strategies[strategy_name](heuristic)

elif strategy_name == 'iterative':
    strategy = available_strategies[strategy_name](3)
else:
    strategy = available_strategies[strategy_name]()

board = parser.parse_file(board_file_name)
print(board)

start = time()
solution = strategies.solve_with_strategy(board, strategy)
running_time = time() - start

if solution:
    print("\nFound solution at depth " + str(board.tiles_left() / 2))
    print(solution)

print("\nStatistics:")
print("\tRunning time " + str(running_time))
print("\tGenerated states " + str(model.number_of_states))
print("\tExpanded nodes " + str(model.number_of_explosions))
print("\tFrontier nodes " + str(model.number_of_states - model.number_of_explosions))

