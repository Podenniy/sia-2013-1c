import parser
import strategies

board = parser.parse_file('../board-generator/board1')
print(board)

for new_board in board.get_new_boards():
    print(new_board)

print strategies.solve_with_strategy(board, strategies.DFS())
