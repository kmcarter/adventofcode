require "./calculator.rb"
p "Started at #{Time.now}"

input = File.open("./input.txt").read.split("\n")
input.map! do |row|
    row.split(" ").each_with_index.map do |inst, i|
        if i > 0
            inst.to_i
        else
            inst
        end
    end
end

#part 1
ip = input[0][1]
input.delete_at(0)
calc = Calculator.new([0,0,0,0,0,0])

calc.run(ip, input)