import numpy as np
from cell import Cell

class AStar:
    def __init__(self, grid):
        self.grid = grid
        self.closedset = []
        self.openset = []

    def heuristic(self, first : Cell, second : Cell):
        return abs(first.r - second.r) + abs(first.c - second.c)

    def get_neighbours(self, current: Cell):
        cords = [
            (0, 1),
            (1, 0),
            (0, -1),
            (-1, 0),
        ]
        current_r = current.r
        current_c = current.c
        grid_rows = len(self.grid)
        grid_cols = len(self.grid[0])

        neighbours = []
        for cord in cords:
            r = current_r + cord[0] # dest r
            c = current_c + cord[1] # dest c
            if 0 <= r < grid_rows and 0 <= c < grid_cols:
                if (ord(self.grid[r][c]) - ord(self.grid[current_r][current_c]) <= 1):
                    c = Cell(r, c)
                    neighbours.append(c)
        return neighbours
    
    def execute(self, start : Cell, end : Cell, part=1):
        current = start

        if part == 1:
            self.openset.append(start)
            start.g_score = 0
            start.h_score = self.heuristic(start, end)
            start.f_score = self.heuristic(start, end)
        elif part == 2:
            for r in range(len(self.grid)):
                for c in range(len(self.grid[0])):
                    if (self.grid[r][c] == 'a'):
                        node = Cell(r, c)
                        self.openset.append(node)
                        node.g_score = 0
                        node.h_score = self.heuristic(node, end)
                        node.f_score = self.heuristic(node, end)

        while self.openset:
            min_cell_idx = np.argmin([n.f_score for n in self.openset])
            current = self.openset[min_cell_idx]

            if current == end:
                break

            self.closedset.append(self.openset.pop(min_cell_idx))

            for n in self.get_neighbours(current):
                if n in self.closedset:
                    continue

                tentative = current.g_score + 1
                tentative_better = False

                if n not in self.openset:
                    self.openset.append(n)
                    n.h_score = self.heuristic(n, end)
                    tentative_better = True
                elif tentative < n.g_score:
                    tentative_better = True

                if tentative_better:
                    n.parent = current
                    n.g_score = tentative
                    n.f_score = n.h_score + n.g_score

        resultgrid = np.zeros(np.array(self.grid).shape)
        while current.parent is not None:
            resultgrid[current.r][current.c] = 1
            current = current.parent
        resultgrid[current.r][current.c] = 1

        #print(resultgrid)

        return np.count_nonzero(resultgrid) - 1
