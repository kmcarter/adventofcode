#part 1
input = File.open('input.txt').read.split("\n")
frequency = 0
for i in input do
    frequency += i.to_i
end
p "Frequency = #{frequency}"