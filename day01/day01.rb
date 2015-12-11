#part 1
input = File.open('input.txt').read
p input.count('(') - input.count(')')

#part 2
floor = 0
index = input.chars.find_index do |c|
  floor += c == '(' ? 1 : -1
  floor < 0
end
p index + 1 #Santa's floor index is 1-based