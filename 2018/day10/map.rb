class Map
    def initialize(points)
        #dimensions = get_map_dimensions(points)
        #p dimensions
        #init_map(dimensions[0], dimensions[1])
    end

    def init_map(width, height)
        @map = []
        (0..height-1).each {|w| @map[w] = Array.new(width, ".") }
        p "#{@map.length}x#{@map[0].length}"
    end

    def print_map
        @map.each {|row| p row.join }
    end

    def map_point(point, seconds = nil)
        position = point.position(seconds)
        mapped_position = [ @upper_edge.abs + position[1], @left_edge.abs + position[0] ]
        #p "Position #{position} mapped to #{mapped_position}"
        @map[mapped_position[0]][mapped_position[1]] = "#"
    end

    def get_map_dimensions(points)
        horz = []
        vert = []
        points.each do |point|
            horz << point.position[0]
            vert << point.position[1]
        end
        @upper_edge = vert.min
        lower_edge = vert.max
        @left_edge = horz.min
        right_edge = horz.max

        p "Left edge = #{@left_edge}"
        p "Upper edge = #{@upper_edge}"

        map_height = @upper_edge.abs + lower_edge.abs + 1
        map_width = @left_edge.abs + right_edge.abs + 1

        [map_width, map_height]
    end
end