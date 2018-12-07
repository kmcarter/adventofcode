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
#p step_prereqs

unique_steps = instructions.flatten.uniq.sort
prereqs = step_prereqs.values.flatten.uniq

def find_next_step(unique_steps, step_prereqs, prereqs, step_order)
    unique_steps.each do |step|
        if step_order.index(step) == nil
            #p "Step #{step} has prereqs #{step_prereqs[step]}"
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
loop do
    #p "Step order so far: #{step_order.join}"
    find_next_step(unique_steps, step_prereqs, prereqs, step_order)

    if step_order.length == unique_steps.length
        break
    end
end
#p "Final step order: #{step_order.join}"

#part 2
base_task_time = 61
num_workers = 5
elapsed_time = 0
tasks_completed = []
tasks_in_progress = []
current_assignments = {}

(0..num_workers-1).each { |worker| current_assignments[worker] = {} }

def get_worker_next_step(unique_steps, step_prereqs, prereqs, tasks_completed, tasks_in_progress)
    next_step = nil
    unique_steps.each do |step|
        if tasks_completed.index(step) == nil && tasks_in_progress.index(step) == nil
            #p "Step #{step} has prereqs #{step_prereqs[step]}"
            if step_prereqs[step] == nil
                next_step = step
                break
            else
                unfinited_prereqs = step_prereqs[step] - tasks_completed
                if unfinited_prereqs.length == 0
                    next_step = step
                    break
                end
            end
        end
    end
    next_step
end

def is_task_done(unique_steps, base_task_time, task, elapsed)
    task != nil && elapsed != nil && unique_steps.index(task) + base_task_time - elapsed <= 0
end

loop do
    p "Second #{elapsed_time}"
    (0..num_workers-1).each do |worker|
        next_task = get_worker_next_step(unique_steps, step_prereqs, prereqs, tasks_completed, tasks_in_progress)
        #p "Next task: #{next_task}"

        if current_assignments[worker]["task"] == nil && next_task != nil
            current_assignments[worker]["task"] = next_task
            current_assignments[worker]["elapsed"] = 0
            tasks_in_progress << current_assignments[worker]["task"]
            p "Assigned worker ##{worker+1} task #{current_assignments[worker]["task"]}"
        end
    end

    (0..num_workers-1).each do |worker|
        if current_assignments[worker]["task"] != nil
            current_assignments[worker]["elapsed"] += 1
            p "Worker ##{worker+1} has spent #{current_assignments[worker]["elapsed"]} seconds on task #{current_assignments[worker]["task"]}"
        end

        if is_task_done(unique_steps, base_task_time, current_assignments[worker]["task"], current_assignments[worker]["elapsed"])
            p "Worker ##{worker+1} completed task #{current_assignments[worker]["task"]} in #{current_assignments[worker]["elapsed"]} seconds"
            tasks_completed << current_assignments[worker]["task"]
            current_assignments[worker]["task"] = nil
        end
    end

    elapsed_time += 1

    if tasks_completed.length == unique_steps.length
        break
    end
end

p "Elapsed time: #{elapsed_time}"