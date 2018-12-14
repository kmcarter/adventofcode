require "./linkedlist.rb"

num_recipes = 9
scoreboard = DoublyLinkedCircularList.new
scoreboard.append(3)
scoreboard.append(7)
elves = [scoreboard.get_by_index(0), scoreboard.get_by_index(1)]

loop do |round|
    #p "############### Round ##{round} ###############"
    recipe_sum = 0
    elves.each_with_index do |score,i|
        recipe_sum += score.value
        #p "Elf ##{i} chose recipe with value #{score.value}"
    end
    recipe_sum.to_s.chars.each {|c| scoreboard.append(c.to_i) }
    #p "Scoreboard: #{scoreboard}"
    elves.map! do |score|
        new_node = score
        score.value.succ.times { new_node = new_node.next }
        new_node
    end
    #p "Elves: #{elves}"

    if scoreboard.length == num_recipes + 10
        break
    end
end

#part 1
last_10_scores = []
score = scoreboard.get_by_index(-10)
10.times do
    last_10_scores << score.value
    score = score.next
end
p last_10_scores.join