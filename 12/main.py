from astar import AStar
from bfs import BFS
from cell import Cell, CellBFS
import numpy as np

def create_grid(filename):
    file = open(filename)
    grid = [list(line.rstrip('\n')) for line in file.readlines()]
    file.close()
    return grid

def find_start_and_end(grid):
    start = None
    end = None

    for r in range(len(grid)):
        for c in range(len(grid[0])):
            if grid[r][c] == 'S':
                start = (r, c)
            elif grid[r][c] == 'E':
                end = (r, c)
            else:
                continue

    return start, end

def part(p, start, end, type):
    if type == 'astar':
        start, end = Cell(start[0], start[1]), Cell(end[0], end[1])
        result = AStar(grid).execute(start, end, p)
        print(result)
    else:
        start, end = CellBFS(start[0], start[1]), CellBFS(end[0], end[1])
        result = BFS(grid).execute(start, end, p)
        print(result)

filename = "input.txt"
grid = create_grid(filename)
start, end = find_start_and_end(grid)

grid[start[0]][start[1]] = 'a'
grid[end[0]][end[1]] = 'z'

type = 'astar'

part(1, start, end, type)
part(2, start, end, type)
