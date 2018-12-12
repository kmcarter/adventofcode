#part 1

input = File.open("example.txt").read.split("\n\n")
initial_state = input[0].split("initial state: ")[1]
notes = input[1].split("\n")
generations = [ [initial_state, 0] ]

notes.map! {|note| note.split(" => ") }
notes.delete_if { |note| note[1] == "." }
notes.map! {|note| note[0] }
p notes

(0..19).each do |gen_i|
    next_gen = []
    first_plant_idx = generations.last.index("#")
    last_plant_idx = generations.last.rindex("#")
    gen = "....." + generations.last[first_plant_idx..last_plant_idx] + "....."
    p "gen #{gen_i} = #{gen}"

    (2..gen.length-3).each do |i|
        local_pots = gen[i-2..i+2]
        produces_plant = notes.index(local_pots) != nil
        p "[#{i}] #{local_pots} => #{produces_plant}"
        
        next_gen << (produces_plant ? "#" : ".")
    end

    generations << [ next_gen.join,  ]
    #p "next #{gen_i+1} = #{next_gen.join}"
end

generations.each_with_index { |gen, i| p "[#{i}] #{gen}" }

p generations.last.count("#")