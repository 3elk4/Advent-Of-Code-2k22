class Cell:
    def __init__(self, r, c):
        self.r = r
        self.c = c
        self.g_score = 0
        self.f_score = 0
        self.h_score = 0
        self.parent = None

    def __eq__(self, cell):
        return self.r == cell.r and self.c == cell.c

    def __hash__(self):
      return hash((self.r, self.c))

    def __str__(self):
     return str((self.r, self.c))

class CellBFS:
    def __init__(self, r, c):
        self.r = r
        self.c = c
        self.parent = None
        self.d = 0

    def __eq__(self, cell):
        return self.r == cell.r and self.c == cell.c

    def __hash__(self):
      return hash((self.r, self.c))

    def __str__(self):
     return str((self.r, self.c))