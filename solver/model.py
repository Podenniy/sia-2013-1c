class Board(object):

    def __init__(self, tiles):
        self.__tiles = tiles

    def remove_match(self, line):

        if len(self.__tiles[line]) == 0:
            return None

        tile = self.__tiles[line][0]
        matching_line = None

        for i in range(len(self.__tiles)):
            if self.__tiles[i][-1] == tile:
                matching_line = i
                break

        if matching_line is None:
            return None

        new_tiles = [l.copy() for l in self.__tiles]

        new_tiles[line].pop(0)
        new_tiles[matching_line].pop()

        return Board(new_tiles)

    def number_of_lines(self):
        return len(self.__tiles)

    def __repr__(self):
        return repr(self.__tiles)

def explode(board):

    children = []
    for i in range(board.number_of_lines()):
        new_board = board.remove_match(i)
        if new_board is not None:
            children.append(new_board)

    return children

