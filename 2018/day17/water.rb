class Water
    def initialize(map)
        @map = map
    end

    def move(x, y)
        current_coord = [x-495, y + 1]
        current_tile = get_tile(next_coord)
        loop do
            if current_tile == "." || current_tile == "|"
                next_coord = [ next_coord[0], next_coord[1] + 1 ]
                next_tile = get_tile(next_coord)
                p next_tile
            #elsif next_tile == "#" || next_tile == "~"
            #    next_coord = [ next_coord[0], next_coord[1] + 1 ]
            #    next_tile = get_tile(next_coord)
            end

            if next_tile == "#"
                break
            end
        end
        @map[next_coord[1]][next_coord[0]] = "~"
    end

    def get_tile(coord)
        @map[coord[1]][coord[0]]
    end
end