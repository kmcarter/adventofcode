#part 1
input = File.open('input.txt').read.split("\n")

instructions = input.map { |row| row.split(" ") }
instructions = instructions.map { |row| [ row[7], row[1] ] }
p instructions

step_prereqs = {}

instructions.sort.each do |step|
    step_prereqs[step[0]] = [] if step_prereqs[step[0]] == nil
    step_prereqs[step[0]] << step[1]
end
p step_prereqs

unique_steps = instructions.flatten.uniq.sort
prereqs = step_prereqs.values.flatten.uniq

def find_step_order(unique_steps, step_prereqs, prereqs, step_order)
    unique_steps.each do |step|
        if step_order.index(step) == nil
            p "Step #{step} has prereqs #{step_prereqs[step]}"
            if step_prereqs[step] == nil
                step_order << step
                break
            else
                unfinited_prereqs = step_prereqs[step] - step_order
                if unfinited_prereqs.length == 0
                    step_order << step
                    break
                end
            end
        end
    end
end

step_order = []
while step_order.length <= step_prereqs.keys.length
    p "Step order so far: #{step_order.join}"
    find_step_order(unique_steps, step_prereqs, prereqs, step_order)
end
p "Final step order: #{step_order.join}"