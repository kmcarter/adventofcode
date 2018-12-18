require "./forest.rb"

input = File.open("input.txt").read.split("\n")
input.map! {|row| row.chars.to_a }

#part 1
forest = Forest.new(input)
#forest.transform(10) # => 1118 * 523 = 584714

#part 2
#forest.transform(10) # => 1118 * 523 = 584714
#forest.transform(100) # => 347 * 197 = 68359
#forest.transform(1000) # => 510 * 316 = 161160
#forest.transform(10000) # => 598 * 311 = 185978
#forest.transform(100000) # => 
#forest.transform(1000000000) # lolwut
# 584714 / 68359 = 8.553
# 584714 / 161160 = 3.628
# 584714 / 185978 = 3.149
forest.count_trees