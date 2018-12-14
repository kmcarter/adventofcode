#part 1
num_rounds = 2018
scoreboard = [3,7]
elves = [0,1]

#p "Elves: #{elves}"
#p "Scoreboard: #{scoreboard}"
(1..num_rounds+10).each do |round|
    #p "############### Round ##{round} ###############"
    recipe_sum = 0
    elves.each_with_index do |previous_recipe_idx,i|
        #current_recipe_idx = 
        #elves[i] = current_recipe_idx
        recipe_sum += scoreboard[previous_recipe_idx]
        #p "Elf ##{i} chose scoreboard index #{previous_recipe_idx} (point value #{scoreboard[previous_recipe_idx]})"
    end
    scoreboard << recipe_sum.to_s.chars.to_a.map {|i| i.to_i}
    scoreboard.flatten!
    #p "Scoreboard: #{scoreboard}"
    elves.map! {|previous_recipe_idx| (scoreboard[previous_recipe_idx].succ + previous_recipe_idx) % scoreboard.length }
    #p "Elves: #{elves}"
end

p scoreboard[num_rounds, 10].join