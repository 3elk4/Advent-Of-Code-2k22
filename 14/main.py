def simulate_sand(p1, rocks, max_y):
  obstacles = rocks.copy()
  while True:
    sand_pos = (500, 0)
    if not p1 and sand_pos in obstacles:
      return len(obstacles) - len(rocks)
    
    while True:
      if p1 and (sand_pos[1] + 1) > max_y:
        return len(obstacles) - len(rocks)
      if not p1 and (sand_pos[1] + 1) == max_y:
        obstacles.add(sand_pos)
        break
        
      if (sand_pos[0], sand_pos[1] + 1) not in obstacles:
        sand_pos = (sand_pos[0], sand_pos[1] + 1)
      elif (sand_pos[0] - 1, sand_pos[1] + 1) not in obstacles:
        sand_pos = (sand_pos[0] - 1, sand_pos[1] + 1)
      elif (sand_pos[0] + 1, sand_pos[1] + 1) not in obstacles:
        sand_pos = (sand_pos[0] + 1, sand_pos[1] + 1)
      else:
        obstacles.add(sand_pos)
        break

filename = "input.txt"

file = open(filename)
lines = [line.strip('\n') for line in file.readlines()]
file.close()

rocks = set()
for line in lines:
    prev = None
    for point in line.split('->'):
      x,y = point.split(',')
      x,y = int(x),int(y)
      if prev is not None:
        dx = x-prev[0]
        dy = y-prev[1]
        
        if(dx == 0 and dy == 0):
          continue
        elif dx == 0:
          for i in range(abs(dy) + 1):
            xx = prev[0]
            yy = prev[1] + i * (1 if dy>0 else -1)
            rocks.add((xx, yy))
        elif dy == 0:
          for i in range(abs(dx) + 1):
            xx = prev[0] + i * (1 if dx>0 else -1)
            yy = prev[1]
            rocks.add((xx, yy))
        else:
          raise Exception('Can\'t parse!')
      prev = (x,y)

max_y = max(r[1] for r in rocks)

print("Part 1:", simulate_sand(True, rocks, max_y))
print("Part 2:", simulate_sand(False, rocks, max_y + 2))