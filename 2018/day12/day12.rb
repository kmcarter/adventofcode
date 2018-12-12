#part 1

input = File.open("input.txt").read.split("\n\n")
initial_state = input[0].split("initial state: ")[1].chars.each_with_index.map { |plant,i| [ i, plant ] }
p initial_state
notes = input[1].split("\n")
generations = [ initial_state ]

notes.map! {|note| note.split(" => ") }
notes.delete_if { |note| note[1] == "." }
notes.map! {|note| note[0] }
p notes

def pad_plants(generation)
    first_plant_idx = generation.index { |plant| plant[1] == "#" }
    first_plant_id = generation[first_plant_idx][0]
    last_plant_idx = generation.rindex { |plant| plant[1] == "#" }
    last_plant_id = generation[last_plant_idx][0]
    generation = generation[first_plant_idx..last_plant_idx]
    (-4..-1).reverse_each {|i| generation.insert(0, [ first_plant_id+i, "." ]) }
    (1..4).each {|i| generation.insert(generation.length, [ last_plant_id+i, "." ]) }
    generation
end

(0..19).each do |gen_i|
    next_gen = []
    gen = pad_plants(generations.last)
    #p "gen #{gen_i} = #{gen}"

    (2..gen.length-3).each do |i|
        local_pots = gen[i-2..i+2].map {|x,y| y}.join
        produces_plant = notes.index(local_pots) != nil
        #p "[#{i}] #{local_pots} => #{produces_plant}"
        
        next_gen << [ gen[i][0], (produces_plant ? "#" : ".") ]
    end
    
    generations << next_gen
    #p "next #{gen_i+1} = #{next_gen.join}"
end
p generations.last

generations.each_with_index { |gen, i| p "[#{i}] #{gen.map{ |x,y| y }.join}" }

sum = 0
generations.last.each do |i, plant|
    sum += i if plant == "#"
end
p sum