import greedy
import logging
import model
import parser
import strategies

from time import time
from sys import argv


logger = logging.getLogger('sia')


def main():
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
        'trivial': greedy.trivial_heuristic,
    }

    def usage(msg = ""):
        logger.debug(msg)
        logger.debug("Usage: %s board_file_path algorithm [heuristic]", argv[0])
        logger.debug("Valid algoriths: %s", ' '.join(available_strategies.keys()))
        logger.debug("Valid heuristics: %s", ' '.join(heuristics.keys()))
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
    logger.debug(board)

    start = time()
    solution = strategies.solve_with_strategy(board, strategy)
    running_time = time() - start

    if solution:
        logger.info("\nFound solution at depth " + str(board.tiles_left() / 2))

    logger.info("\nStatistics:")
    logger.info("\tRunning time " + str(running_time))
    logger.info("\tGenerated states " + str(model.number_of_states))
    logger.info("\tExpanded nodes " + str(model.number_of_explosions))
    logger.info("\tFrontier nodes " + str(model.number_of_states - model.number_of_explosions))

if __name__ == '__main__':
    FORMAT = '%(message)s'
    logging.basicConfig(format=FORMAT)
    logger.setLevel(logging.INFO)
    main()
