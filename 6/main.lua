function uniq_chars(str)
    for i = 1, string.len(str) do
      for j = i+1, string.len(str) do
        if string.sub(str, i, i) == string.sub(str, j, j) then
          return false
        end
      end
    end
  
    return true
  end
  
  file = io.open ('input.txt', 'r')
  message = file:read()
  io.close(file)
  
  offset = 13 -- task1: 3
  l = string.len(message)
  
  for i = 1, l-offset do
    substr = string.sub(message, i, i+offset)
    if uniq_chars(substr) then
      print(i+offset)
      break
    end
  end