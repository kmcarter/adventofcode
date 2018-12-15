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

    def get_unit_locations(type)
        locations = []
        @map.each_with_index do |row, y|
            row.each_with_index do |cell, x|
                locations << [x, y] if cell == type
            end
        end
        locations
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

    def each_square
        @map.each_with_index do |row, y|
            row.each_with_index do |cell, x|
                yield(cell, x, y)
            end
        end
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