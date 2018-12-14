require "./linkedlist.rb"

num_recipes = 540391
scoreboard = DoublyLinkedCircularList.new
scoreboard.append(3)
scoreboard.append(7)
elves = [scoreboard.get_by_index(0), scoreboard.get_by_index(1)]

def round(elves, scoreboard)
    #p "############### Round ##{round} ###############"
    recipe_sum = 0
    elves.each_with_index do |score,i|
        recipe_sum += score.value
        #p "Elf ##{i} chose recipe with value #{score.value}"
    end
    new_scores = recipe_sum.to_s.chars.to_a
    new_scores.each { |c| scoreboard.append(c.to_i) }
    #p "Scoreboard: #{scoreboard}"
    elves.map! do |score|
        new_node = score
        score.value.succ.times { new_node = new_node.next }
        new_node
    end
    #p "Elves: #{elves}"
    new_scores
end

def part1(elves, scoreboard, num_recipes)
    loop do
        round(elves, scoreboard)
        if scoreboard.length == num_recipes + 10
            break
        end
    end

    last_10_scores = []
    score = scoreboard.get_by_index(-10)
    10.times do
        last_10_scores << score.value
        score = score.next
    end
    p last_10_scores.join
end

def part2(elves, scoreboard, search_term)
    search_term = search_term.to_s
    last5digits = ""
    iterations = 0
    found_it = false
    loop do
        new_scores = round(elves, scoreboard)
        new_scores.each_with_index do |score, i|
            last5digits += score
            last5digits = last5digits.slice(-search_term.length, search_term.length) if last5digits.length > search_term.length

            #p "#{last5digits} =? #{search_term} (iteration ##{iterations})"
            if last5digits == search_term
                p "Part 2: #{scoreboard.length - search_term.length - new_scores.length + i.succ} (took #{iterations} rounds)"
                found_it = true
                break
            end
        end
        iterations += 1
        break if found_it
    end
end

part2(elves, scoreboard, num_recipes)