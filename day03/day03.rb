#part 1
input = File.open('input.txt').read
map = { "[0, 0]" => 1 }
current_position = [0, 0]
input.chars.each do |c|
  x = current_position.first + ((1 if c == '>') || (-1 if c == '<') || 0)
  y = current_position.last + ((1 if c == '^') || (-1 if c == 'v') || 0)
  current_position = [x, y]
  map[current_position.to_s] = map.fetch(current_position.to_s, 0) + 1
end
p map.count