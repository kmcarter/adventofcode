require 'yaml'
require "./calculator.rb"

input = File.open("input.txt").read.split("\n\n\n\n")
input = input[0].split("\n\n")
input.map! do |block|
    block.split("\n")
end
input.map! do |block|
    registers = YAML.load(block[0].split(": ")[1])
    instructions = block[1].split(" ").map {|s| s.to_i}
    expected = YAML.load(block[2].split(":  ")[1])
    [ registers, instructions, expected ]
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
    (0..10).each do
        input.each do |block|
            #p block[1][0]
            if calc.operations[block[1][0]] == nil
                matches = calc.try_all(block[0], block[1], block[2])
                calc.match_operations(matches, block[0], block[1], block[2])
            end
        end
        p calc.operations

        if calc.operations.index(nil) == -1
            break
        end
    end
end

part2(calc, input)

#calc.try_all([2, 0, 2, 3], [15, 2, 3, 0], [0, 0, 2, 3])