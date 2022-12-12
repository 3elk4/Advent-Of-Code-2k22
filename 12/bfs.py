from collections import defaultdict, deque
from cell import CellBFS

class BFS:
    def __init__(self, grid):
        self.grid = grid

    def execute(self, start, end, part=1):
        visited = set()
        queue = deque()

        grid_rows = len(self.grid)
        grid_cols = len(self.grid[0])

        if(part == 1):
            queue.append(start)
        elif(part == 2): 
            for r in range(len(self.grid)):
                for c in range(len(self.grid[0])):
                    if (self.grid[r][c] == 'a'):
                        queue.append(CellBFS(r, c))

        state = None

        while queue:
            state = queue.popleft()
            if state in visited:
                continue

            visited.add(state)

            if state == end:
                return state.d

            for next_state in [(-1,0),(0,1),(1,0),(0,-1)]:
                rr = state.r + next_state[0] # dest r
                cc = state.c + next_state[1] # dest c
                if 0 <= rr < grid_rows and 0 <= cc < grid_cols:
                    if (ord(self.grid[rr][cc]) - ord(self.grid[state.r][state.c]) <= 1):
                        c = CellBFS(rr, cc)
                        c.d = state.d + 1
                        c.parent = state
                        queue.append(c)

        return state.d
