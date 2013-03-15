from model import Board

def parse_file(file_name):

    tiles = []
    with open(file_name) as f:
        num_lines = int(f.readline())

        for i in range(num_lines):
            line = [int(tile) for tile in f.readline().split(' ')]
            tiles.append(line)

    return Board(tiles)

