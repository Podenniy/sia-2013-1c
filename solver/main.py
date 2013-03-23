import parser
import strategies
import model

from time import time
from sys import argv

available_strategies = {
    'dfs': strategies.DFS,
    'bfs': strategies.BFS,
    'iterative': strategies.IterativeDeepening,
    'A*': None,
    'greedy': None,
}

needs_heuristics = ['A*', 'greedy']

heuristics = {
    'slim': strategies.slim_heuristic,
    'fat': strategies.fat_heuristic,
}

def usage(msg = ""):
    print(msg)
    print("Usage: " + argv[0] + " algorithm [heuristic]")
    print("Valid algoriths: " + ' '.join(available_strategies.keys()))
    print("Valid heuristics: " + ' '.join(heuristics.keys()))
    exit(0)

if len(argv) < 2:
    usage()

strategy_name = argv[1]
if strategy_name not in available_strategies:
    usage("Pick a valid strategy name")

heuristic = None
if strategy_name in needs_heuristics:
    if len(argv) != 3:
        usage(strategy_name + " needs an heuristic")
    if argv[2] not in heuristics:
        usage("Pick a valid heuristic name")

    heuristic = heuristics[argv[2]]
    strategy = available_strategies[strategy_name](heuristic)

elif strategy_name == 'iterative':
    strategy = available_strategies[strategy_name](3)
else:
    strategy = available_strategies[strategy_name]()

board = parser.parse_file('../board-generator/board1')
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

