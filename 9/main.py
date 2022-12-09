def tailNear(T, H):
  dh = abs(H[0] - T[0])
  dv = abs(H[1] - T[1])
  return dh <=1 and dv <= 1

def moveHead(H, dir):
  if dir ==  "R":
    H = (H[0] + 1, H[1])
    #print(H)
    return H
  elif dir == "L":
    H = (H[0] - 1, H[1])
    #print(H)
    return H
  elif dir == "U":
    H = (H[0], H[1] - 1)
    #print(H)
    return H
  elif dir == "D":
    H = (H[0], H[1] + 1)
    #print(H)
    return H
  else:
    raise ValueError('Case not found.')

def moveTail(T, H):
  dh = abs(H[0] - T[0])
  dv = abs(H[1] - T[1])

  if dh >= 2 and dv >=2:
    T = (H[0]-1 if T[0]<H[0] else H[0]+1, H[1]-1 if T[1]<H[1] else H[1]+1)
  elif dh >= 2:
    T = (H[0]-1 if T[0]<H[0] else H[0]+1, H[1])
  elif dv >= 2:
    T = (H[0], H[1]-1 if T[1]<H[1] else H[1]+1)
  
  return T


filename = "input.txt"

# part1
H = (0, 0)
T = (0, 0)
visited = set([T])

file = open(filename)

for line in file.readlines():
  params = line.rstrip('\n').split(' ')

  for _ in range(int(params[1])):
    H = moveHead(H, params[0])

    if not tailNear(T, H):
      T = moveTail(T, H)
      visited.add(T)

file.close()

print("PART1 RESULT: " + str(len(visited)))

# part 2
H = (0, 0)
T = [(0,0) for _ in range(9)]
visited = set([T[8]])

file = open(filename)

for line in file.readlines():
  params = line.rstrip('\n').split(' ')

  for _ in range(int(params[1])):
    H = moveHead(H, params[0])

    if not tailNear(T[0], H):
      T[0] = moveTail(T[0], H)

    for i in range(1, 9):
      if not tailNear(T[i], T[i-1]):
        T[i] = moveTail(T[i], T[i-1])
         
    visited.add(T[8])
    
print("PART2 RESULT: " + str(len(visited)))

file.close()