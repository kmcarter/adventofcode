require 'date'

#part 1
input = File.open('input.txt').read.split("\n")

input.map! { |line| line.slice(1..-1).split("] ") }
input.map! { |x,y| [DateTime.parse(x), y] }
input.sort!
#input.each { |x,y| p "#{x.to_s}: #{y}" }

guards = {}
guard_id = nil
fell_asleep_at_min = nil
woke_up_at_min = nil
input.each do |x,y|
    shift_date = x.strftime("%m-%d")

    if y.index("Guard #") != nil
        guard_id = y.slice(/\d+/)
        #p "Guard ##{guard_id}"

        if guards[guard_id] == nil
            guards[guard_id] = {}
        end
    elsif y.index("falls asleep") != nil
        if guards[guard_id][shift_date] == nil
            guards[guard_id][shift_date] = []
            (0..59).each{ |minute| guards[guard_id][shift_date][minute] = false }
        end

        fell_asleep_at_min = x.strftime("%M").to_i
        guards[guard_id][shift_date][fell_asleep_at_min] = true
        woke_up_at_min = nil
    else
        woke_up_at_min = x.strftime("%M").to_i - 1
        for m in fell_asleep_at_min..woke_up_at_min
            guards[guard_id][shift_date][m] = true
        end
        #p "guards[#{guard_id}][#{shift_date}] = #{guards[guard_id][shift_date]}"
        fell_asleep_at_min = nil
    end
end

sleepiest_guard = nil
longest_sleep_time = 0
guards.each do |x,y| 
    p "Guard ##{x}"
    mins_asleep = 0
    y.each do |shift,minutes|
        mins_asleep += minutes.select { |e| e }.length
        p "#{shift}: asleep #{mins_asleep} min"
    end
    p "#{mins_asleep} TOTAL MINS ASLEEP"

    if mins_asleep > longest_sleep_time
        sleepiest_guard = x
        longest_sleep_time = mins_asleep
    end
end

p "Sleepiest guard: #{sleepiest_guard} (asleep #{longest_sleep_time} total mins)"

minute_totals = []
(0..59).each{ |minute| minute_totals[minute] = 0 }
(0..59).each do |minute|
    guards[sleepiest_guard].each { |day,log| minute_totals[minute] += 1 if log[minute] }
end

sleepiest_minute = 0
sleepiest_minute_val = 0
minute_totals.each_with_index do |val,i|
    if val > sleepiest_minute_val
        sleepiest_minute = i
        sleepiest_minute_val = val
    end
end
p "Sleepiest minute: #{sleepiest_minute} (asleep for #{sleepiest_minute_val} shifts)"
p "Strat 1 sleepy checksum: #{sleepiest_guard.to_i * sleepiest_minute.to_i}"

#part 2
sleepiest_guard = nil
sleepiest_minute = 0
sleepiest_minute_val = 0
guards.each do |guard,shifts|
    minute_totals = []
    (0..59).each{ |minute| minute_totals[minute] = 0 }
    (0..59).each do |minute|
        shifts.each { |day,log| minute_totals[minute] += 1 if log[minute] }
    end
    minute_totals.each_with_index do |val,i|
        if val > sleepiest_minute_val
            sleepiest_minute = i
            sleepiest_minute_val = val
            sleepiest_guard = guard
        end
    end
end
p "Strat 2: Guard ##{sleepiest_guard} was asleep #{sleepiest_minute_val} times on minute #{sleepiest_minute}"
p "Strat 2 sleepy checksum: #{sleepiest_guard.to_i * sleepiest_minute.to_i}"