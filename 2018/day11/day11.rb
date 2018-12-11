#part 1
serial_num = 3463

def fuel_level(x, y, serial_num)
    rack_id = x + 10
    power_level = rack_id * y + serial_num
    power_level *= rack_id
    power_level = power_level.to_s.reverse[2].to_i || 0
    power_level - 5
end

#p "Fuel level 1: #{fuel_level(122, 79, 57)}"
#p "Fuel level 2: #{fuel_level(217, 196, 39)}"
#p "Fuel level 3: #{fuel_level(101, 153, 71)}"

largest_coord = nil
largest_fuel = 0
largest_grid_size = 0

(0..300).each_with_index do |row, r|
    (0..300).each_with_index do |cell, c|
        (4..20).each do |grid_size|
            break if r + grid_size > 300 || c + grid_size > 300

            total_fuel = 0
            (r..r+grid_size).each do |r_|
                (c..c+grid_size).each { |c_| total_fuel += fuel_level(r_, c_, serial_num) }
            end

            if total_fuel > largest_fuel
                largest_fuel = total_fuel
                largest_coord = [r, c]
                largest_grid_size = grid_size + 1
                p "Largest so far: #{largest_coord}, size #{largest_grid_size}, fuel #{largest_fuel}"
            end
        end
    end
end

p "Coord #{largest_coord} with grid size #{largest_grid_size} has most fuel (#{largest_fuel})"