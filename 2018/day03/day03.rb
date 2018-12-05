#part 1
input = File.open("input.txt").read.split("\n")
input.map! do |row| 
    index_of_at = row.index("@ ") + 2
    row.slice(index_of_at..-1).split(": ")
end
input.map! { |x,y| [x.split(","), y.split("x")] }

fabric_map = []

input.each do |claim|
    start_vert_index = claim[0][1].to_i
    start_horz_index = claim[0][0].to_i
    height = claim[1][1].to_i
    width = claim[1][0].to_i

    #p "Starting at #{start_horz_index}x#{start_vert_index}"

    #height first so it's easier to print columns
    (0..height-1).each do |h|
        v_index = start_vert_index + h
        if fabric_map[v_index] == nil
            fabric_map[v_index] = []
        end

        (0..width-1).each do |w|
            h_index = start_horz_index + w
            if fabric_map[v_index][h_index] == nil
                fabric_map[v_index][h_index] = 0
            end

            fabric_map[v_index][h_index] += 1
            #p "Incrementing #{h_index}x#{v_index} to #{fabric_map[v_index][h_index]}"
        end
    end
end

num_overlapping_squares = 0
fabric_map.each do |row|
    #p row
    if row != nil
        row.each { |cell| num_overlapping_squares += 1 if cell != nil && cell > 1 }
    end
end
p num_overlapping_squares