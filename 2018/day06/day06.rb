#part 1
input = File.open('input.txt').read.split("\n")
coords = []

input.each do |row|
    split = row.split(", ")
    coords << [ split[0].to_i, split[1].to_i ]
end

#build a map
map = []

#p input
furthest_edge = coords.flatten.max.to_i
#p furthest_edge

(0..furthest_edge).each do |row|
    map << []
    map[row] = []
    (0..furthest_edge).each do |cell|
        map[row][cell] = "#{row}x#{cell} "
    end
end

coords.each_with_index do |coord, i|
    #p coord
    map[coord[0]][coord[1]] = i
end

#map.each { |row| p row.join }

map.each_with_index do |row, r|
    row.each_with_index do |cell, c|
        is_coord = false
        distances = []

        coords.each_with_index do |coord, ci|
            distance = (coord[0] - r).abs + (coord[1] - c).abs
            distances << distance
            #p "How far away is #{r}x#{c} from #{coord}? #{distance}"

            if distance == 0
                is_coord = true
            end
        end

        instances_of_closest = distances.select { |i| i == distances.min }
        #p "Intersection #{instances_of_closest}"

        if is_coord
            map[r][c] = 'x'
        elsif instances_of_closest.length > 1
            #p "#{r}x#{c} is tied (disqualified)"
            map[r][c] = '.'
        else
            #p "#{r}x#{c} is closest to #{coords[distances.index(distances.min)]} (#{distances.min} away)"
            map[r][c] = distances.index(distances.min)
        end
    end
end

#map.each { |row| p row.join }

#eliminate coords on edges
infinite_coord_ids = []
map.each_with_index do |row, i|
    if i == 0 || i == furthest_edge
        infinite_coord_ids << row
    else
        row.each_with_index do |cell, ci|
            if ci == 0 || i == furthest_edge
                infinite_coord_ids << cell
            end
        end
    end
end

infinite_coord_ids.flatten!.uniq!.delete(".")
infinite_coord_ids.delete("x")
#p infinite_coord_ids

eligible_coords = Array.new(coords)
infinite_coord_ids.each { |i| eligible_coords[i] = nil }
#p coords

coords_with_total_area = {}
eligible_coords.each_with_index do |coord, i|
    squares = 1 #start at one, b/c the coord itself counts as a square
    if coord != nil
        map.each do |row|
            row.each do |cell|
                squares += 1 if cell == i
            end
        end
    end
    coords_with_total_area[i] = squares
end
p coords_with_total_area

p "Largest size = #{coords_with_total_area.values.max}"

#part 2
region_size = 0
map.each_with_index do |row,r|
    row.each_with_index do |cell,c|
        distance = 0
        coords.each do |coord|
            distance += (coord[0] - r).abs + (coord[1] - c).abs
        end
        
        region_size += 1 if distance < 10000
    end
end

p region_size