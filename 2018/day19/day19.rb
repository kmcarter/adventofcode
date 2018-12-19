require "./calculator.rb"

input = File.open("./example.txt").read.split("\n")
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

p calc.run(ip, input)