require "./water.rb"

spring = [500, 0]
input = File.open("./example.txt").read.split("\n")
input.map! {|line| line.split(", ")}
input.map! do |coords|
    x = nil
    y = nil
    coords.each do |coord|
        coord_split = coord.split("=")
        if coord_split[1].index("..") != nil
            coord_split[1] = coord_split[1].split("..")
            coord_split[1].map! {|pole| pole.to_i }
        else
            coord_split[1] = coord_split[1].to_i
        end

        x = coord_split[1] if coord_split[0] == "x"
        y = coord_split[1] if coord_split[0] == "y"
    end
    [ x, y ]
end
p input

smallest_x = 500
largest_x = 500
largest_y = 0

input.each do |coords|
    if coords[0].kind_of? Integer
        smallest_x = coords[0] if coords[0] < smallest_x
        largest_x = coords[0] if coords[0] > largest_x
    else
        smallest_x = coords[0].min if coords[0].min < smallest_x
        largest_x = coords[0].max if coords[0].max > largest_x
    end

    if coords[1].kind_of? Integer
        largest_y = coords[1] if coords[1] > largest_y
    else
        largest_y = coords[1].max if coords[1].max > largest_y
    end
end

p "Smallest to largest X: #{smallest_x} -> #{largest_x}"
p "Largest Y: #{largest_y}"

map = []
largest_y.succ.times.each do
    map << Array.new(largest_x - smallest_x, ".")
end
#map.each {|row| p row.join }

input.each do |coords|
    if coords[0].kind_of?(Integer) && coords[1].kind_of?(Integer)
        map[coords[1]][coords[0]-495] = "#"
    elsif coords[1].kind_of? Integer
        coords[0][0].upto(coords[0][1]).each { |x| map[coords[1]][x-495] = "#" }
    else
        coords[1][0].upto(coords[1][1]).each { |y| map[y][coords[0]-495] = "#" }
    end
end
map[spring[1]][spring[0]-495] = "+"
map.each {|row| p row.join }

water = Water.new(map)
water.move(500, 0)
map.each {|row| p row.join }
