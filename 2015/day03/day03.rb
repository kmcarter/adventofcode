input = File.open('input.txt').read
map = { "[0, 0]" => 2 }
santa_current_position = [0, 0]
robo_current_position = [0, 0]
input.chars.each_with_index do |c,i|
  current_position = i % 2 == 0 ? robo_current_position : santa_current_position
  x = current_position.first + ((1 if c == '>') || (-1 if c == '<') || 0)
  y = current_position.last + ((1 if c == '^') || (-1 if c == 'v') || 0)
  current_position = [x, y]
  
  if i % 2 == 0
    robo_current_position = current_position
  else
    santa_current_position = current_position
  end
  
  map[current_position.to_s] = map.fetch(current_position.to_s, 0) + 1
end
p map.count