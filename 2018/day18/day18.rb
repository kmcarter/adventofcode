require "./forest.rb"

input = File.open("input.txt").read.split("\n")
input.map! {|row| row.chars.to_a }

#part 1
forest = Forest.new(input)

forest.transform(10)
forest.count_trees