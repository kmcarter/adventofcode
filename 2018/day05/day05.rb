#part 1
input = File.open('input.txt').read
#input = 'dabAcCaCBAcCcaDA'
#p input

def react_polymer(str)
    previous_char = nil
    new_str = String.new(str)
    count = 0
    
    str.chars.each_with_index do |char,i|
        if previous_char != nil && (char <=> previous_char) != 0 && char.casecmp(previous_char) == 0
            #p (i-1-(count*2))..(i-(count*2))
            new_str.slice!(i-1-(count*2)..i-(count*2))
            #p new_str
            count += 1
            previous_char = nil
        else
            previous_char = char
        end
    end
    
    if str.length > new_str.length
        new_str = react_polymer new_str
    end
    
    return new_str
end

output = react_polymer input
p output.length