require "./forest.rb"

input = File.open("input.txt").read.split("\n")
input.map! {|row| row.chars.to_a }

#part 1
forest = Forest.new(input)
#forest.transform(10) # => 1118 * 523 = 584714

#part 2
#forest.transform(100) # => 347 * 197 = 68359
#forest.transform(10000) # => 510 * 316 = 161160

forest.count_trees
#169472 appears every 28 minutes
#p ((1000000000 - 466) % 28) + 466
forest.transform(468)