require "./point.rb"
require "./map.rb"

input = File.open("input.txt").read
points = []

input.each_line("\n") do |row|
    str_arr = row.split(/[<>]/)
    position = str_arr[1].delete(" ").split(",").map! {|n| n.to_i}
    velocity = str_arr[3].delete(" ").split(",").map! {|n| n.to_i}
    points << Point.new(position, velocity)
end

#p points

map = Map.new(points)

points.each { |point| point.position(10027) }
p points

dimensions = map.get_map_dimensions(points)
map.init_map(dimensions[0], dimensions[1])
points.each {|point| map.map_point(point) }

map.print_map

#p dimensions