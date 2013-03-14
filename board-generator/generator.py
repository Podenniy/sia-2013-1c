from random import Random

# Constants
TILES = 144
LINES = 12 # This is tradionally 8, but since we're using a 2D board...
TILES_PER_LINE = TILES // LINES

tiles = [str(t) for t in range(TILES)] * 2
Random().shuffle(tiles)

print(LINES)
print('\n'.join(' '.join(tiles[i:i + TILES_PER_LINE]) for i in range(TILES_PER_LINE)))

