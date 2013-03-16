from parser import parse_file

board = parse_file('../board-generator/board1')
print(board)

for new_board in board.get_new_boards():
    print(new_board)
