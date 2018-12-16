require 'yaml'
require "./calculator.rb"

input = File.open("input.txt").read.split("\n\n\n\n")
input = input[0].split("\n\n")
input.map! do |block|
    block.split("\n")
end

valid_blocks = 0
input.each do |block|
    registers = YAML.load(block[0].split(": ")[1])
    instructions = block[1].split(" ").map {|s| s.to_i}
    expected = YAML.load(block[2].split(":  ")[1])
    p registers
    p instructions
    p expected

    calc = Calculator.new

    valid_blocks += 1 if calc.try_all(registers, instructions, expected) > 3
end
p "Valid blocks = #{valid_blocks}"