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