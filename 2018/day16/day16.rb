require 'yaml'
require "./calculator.rb"

file_input = File.open("input.txt").read.split("\n\n\n\n")
input = file_input[0].split("\n\n")
input.map! do |block|
    block.split("\n")
end
input.map! do |block|
    registers = YAML.load(block[0].split(": ")[1])
    instructions = block[1].split(" ").map {|s| s.to_i}
    expected = YAML.load(block[2].split(":  ")[1])
    [ registers, instructions, expected ]
end
instructions = file_input[1].split("\n")
instructions.map! do |block|
    arr = block.split(" ")
    arr.map! {|c| c.to_i }
    arr
end

calc = Calculator.new

def part1(calc, input)
    valid_blocks = 0
    input.each do |block|
        valid_blocks += 1 if calc.try_all(registers, instructions, expected).length >= 3
    end

    p "Valid blocks = #{valid_blocks}"
end

def part2(calc, input)
    possible_matches = Array.new(16, [])
    input.each do |block|
        #p block[1][0]
        if calc.operations[block[1][0]] == nil
            matches = calc.try_all(block[0], block[1], block[2])
            possible_matches[block[1][0]] = matches
            #calc.match_operations(matches, block[0], block[1], block[2])
        end
    end
    possible_matches.each_with_index {|op,i| puts "#{i}: #{op}" }

    loop do
        new_val = calc.match_operations(possible_matches)
        p calc.operations

        next_filter = possible_matches.select {|arr| arr.length == 1}
        if (next_filter.length == 0)
            break;
        end
    end
end

#calc.try_all([2, 0, 2, 3], [15, 2, 3, 0], [0, 0, 2, 3])

#part1(calc, input)
#part2(calc, input)

register = [0, 0, 0, 0]
instructions.each do |instruction|
    operation = calc.operations[instruction[0]]
    register = calc.public_send(operation, register, instruction)
end
p register
