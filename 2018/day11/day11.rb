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

grid = Array.new(298, Array.new(298, 0))
largest_coord = nil
largest_fuel = 0

grid.each_with_index do |row, r|
    row.each_with_index do |cell, c|
        #UGLY
        total_fuel = fuel_level(r, c, serial_num)
        total_fuel += fuel_level(r + 1, c, serial_num)
        total_fuel += fuel_level(r + 2, c, serial_num)
        total_fuel += fuel_level(r, c + 1, serial_num)
        total_fuel += fuel_level(r, c + 2, serial_num)
        total_fuel += fuel_level(r + 1, c + 1, serial_num)
        total_fuel += fuel_level(r + 2, c + 1, serial_num)
        total_fuel += fuel_level(r + 1, c + 2, serial_num)
        total_fuel += fuel_level(r + 2, c + 2, serial_num)
        grid[r][c] = total_fuel

        if total_fuel > largest_fuel
            largest_fuel = total_fuel
            largest_coord = [r, c]
        end
    end
end

p "Coord #{largest_coord} has most fuel (#{largest_fuel})"