#part 1
input = File.open('input.txt').read.split("\n")
frequency = 0
for i in input do
    frequency += i.to_i
end
p "(part 1) Frequency = #{frequency}"

#part 2
#input = ['-6','+3','+8','+5','-6']
frequency = 0
i = 0
already_seen_freqs = []
freq_found_twice = false

#this will run for several minutes before it finds a match
while !freq_found_twice
    frequency += input[i].to_i

    #p already_seen_freqs.length
    if already_seen_freqs.include?(frequency)
        p "(part 2) First frequency to appear twice = #{frequency}"
        freq_found_twice = true
    else
        already_seen_freqs << frequency
        #p "Added #{frequency} to array"
    end

    i += 1
    if input.length.equal?(i)
        i = 0
    end
end