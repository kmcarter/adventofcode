require "./terrain.rb"

class Environment
    def initialize(input)
        @map = process_input(input)
    end

    def get_terrain(x, y)
        raw = @map[y][x]
        return :floor if raw != "#"
        return :wall
    end

    def terrain_moveable?(location)
        terrain = @map[location[1]][location[0]]
        return terrain == :floor
    end

    def get_empty_terrain
        locations = []
        @map.each_with_index do |row, y|
            row.each_with_index do |cell, x|
                locations << [x, y] if cell == "."
            end
        end
        locations
    end

    def distance_from(here, there)
        shortest_distance = -1

        if is_accessible?(here) && is_accessible?(there)
            p "Testing #{here} to #{there}"
            x_dist = (here[0] - there[0]).abs
            y_dist = (here[1] - there[1]).abs
            p "x distance = #{x_dist}, y distance = #{y_dist}"

            x_dir = there[0] <=> here[0]
            y_dir = there[1] <=> here[1]
            p "x dir = #{x_dir}, y dir = #{y_dir}"
            
            if x_dir == 0
                next_loc = y_dir == 1 ? down(here)
            elsif y_dir == 0
                next_loc = x_dir == 1 ? 
            
            #p "a path can be found! #{there}"
        end
        shortest_distance
    end

    def up(from_loc)
        [ from_loc[0], from_loc[1] - 1 ]
    end

    def down(from_loc)
        [ from_loc[0], from_loc[1] + 1 ]
    end

    def left(from_loc)
        [ from_loc[0] - 1, from_loc[1] ]
    end

    def right(from_loc)
        [ from_loc[0] + 1, from_loc[1] ]
    end

    def each_square
        @map.each_with_index do |row, y|
            row.each_with_index do |cell, x|
                yield(cell, x, y)
            end
        end
    end

    def is_accessible?(location)
        terrain_moveable?(up(location)) || terrain_moveable?(down(location)) || terrain_moveable?(left(location)) || terrain_moveable?(right(location))
    end

    def map_units(units)
        reset_map
        units.each do |unit|
            @map[unit.location[1]][unit.location[0]] = unit.type_str
        end
    end

    def reset_map
        @map.map! do |row|
            row.map! do |cell|
                cell.set(:floor)
                cell
            end
            row
        end
    end

    def print
        @map.each {|y| puts y.join }
    end

    private
    def process_input(input)
        map = input.split("\n")
        map.map! do |row|
            column = []
            row.chars.each do |c|
                column << Terrain.new(c)
            end
            column
        end
        map
    end
end