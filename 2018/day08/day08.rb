#part 1
require "./treereader.rb"
require "./node.rb"
input = File.open('input.txt').read.split(" ")
input.map! { |num| num.to_i }

p input

tree = TreeReader.new(input)

root = tree.read_node

p root.sum_metadata