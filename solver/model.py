# ?
import copy


def get_lines(match):
    line1, line2 = match
    if line1 < 0:
        line1 = -line1
    if line2 < 0:
        line2 = -line2
    return line1-1, line2-1

def get_positions(match):
    position1 = 0 if match[0] > 0 else -1
    position2 = 0 if match[1] > 0 else -1
    return position1, position2

class Board(object):

    def __init__(self, tiles):
        self.__tiles = tiles

    def get_matches(self):
        """Returns a list of tuples with the possible moves.
        (token1, token2). token1 and token2 are integers in the range
        [1..len(self.__tiles)] if the token is on the left
        [-len(self.__tiles)..-1] if the token is on the right side
        """
        matches = []
        for line in range(len(self.__tiles)):
            if not self.__tiles[line]:
                continue
            # Lefty with another lefty
            for second_line in range(line+1, len(self.__tiles)):
                if not self.__tiles[second_line]:
                    continue
                if self.__tiles[line][0] == self.__tiles[second_line][0]:
                    matches.append((line+1, second_line+1))
            # Lefty with righty
            for second_line in range(len(self.__tiles)):
                if not self.__tiles[second_line] or second_line == line:
                    continue
                if self.__tiles[line][0] == self.__tiles[second_line][-1]:
                    matches.append((line+1, ~second_line))
            # righty with righty
            for second_line in range(line+1, len(self.__tiles)):
                if not self.__tiles[second_line]:
                    continue
                if self.__tiles[line][-1] == self.__tiles[second_line][-1]:
                    matches.append((~line, ~second_line))
        return matches

    def get_new_boards(self):
        matches = self.get_matches()
        return [self.mutate_board(match) for match in matches]

    def mutate_board(self, match):
        new_tiles = copy.deepcopy(self.__tiles)

        line1, line2 = get_lines(match)
        position1, position2 = get_positions(match)
        new_tiles[line1].pop(position1)
        new_tiles[line2].pop(position2)

        return Board(new_tiles)

    def number_of_lines(self):
        return len(self.__tiles)

    def is_empty(self):
        return len([line for line in self.__tiles if not len(line)])

    def __repr__(self):
        return repr(self.__tiles)

