#part 1
input = File.open('input.txt').read
packages = input.split("\n").map { |line| line.split('x').map { |e| e.to_i }.sort }
paper = 0
packages.each do |package|
  paper += package.first * package[1] #add slack for shortest side
  3.times do
    paper += 2 * package.first * package[1]
    package.rotate!
  end
end
p paper