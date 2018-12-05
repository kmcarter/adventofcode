#part 1
input = File.open("input.txt").read.split("\n")
#input = ['abcdef','bababc','abbcde','abcccd','aabcdd','abcdee','ababab']
num_twos = 0
num_threes = 0

input.each do |ele|
    char_hash = {}
    ('a'..'z').each{ |letter| char_hash.store(letter,0)}
    ele.chars.each { |letter| char_hash[letter] += 1 }
    
    if char_hash.select { |k,v| v == 3 }.length > 0
        num_threes += 1
    end
    if char_hash.select { |k,v| v == 2 }.length > 0
        num_twos += 1
    end
end
p "Checksum of #{num_twos} * #{num_threes} = #{num_twos * num_threes}"

#part 2
input.each do |first|
    first_char_arr = first.chars
    input.each do |second|
        second_char_arr = second.chars.to_a

        different_chars = 0
        first_char_arr.each_with_index { |c,i| different_chars += 1 if c != second_char_arr[i] }

        p "Box IDs #{first} and #{second} differ by 1 character!" if different_chars == 1
    end
end