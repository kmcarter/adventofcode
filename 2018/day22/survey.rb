class Survey
    def initialize(depth, target)
        @depth = depth
        @target = target
        @map = []
    end

    def map_erosion_levels
        (0..@target[0]).each do |x|
            (0..@target[1]).each do |y|
                set_tile_at_index(x, y, erosion_level(x, y))
            end
        end
    end

    def map_risk_levels
        risk_level = 0
        (0..@target[0]).each do |x|
            (0..@target[1]).each do |y|
                risk_level += risk_level_by_erosion_level(get_tile_at_index(x, y))
            end
        end
        risk_level
    end

    def print_map
        (0..@target[0]).each do |x|
            (0..@target[1]).map { |y| p "#{x},#{y} = #{get_tile_at_index(x, y)}" }
        end
    end

    private
    def set_tile_at_index(x, y, val)
        @map[y * @target[0].succ + x] = val
    end

    def get_tile_at_index(x, y)
        @map[y * @target[0].succ + x]
    end

    def geologic_index(x, y)
        if x == 0 && y == 0
            0
        elsif @target[0] == x && @target[1] == y
            0
        elsif y == 0
            x * 16807
        elsif x == 0
            y * 48271
        else
            get_tile_at_index(x-1, y) * get_tile_at_index(x, y-1)
            #erosion_level(x-1, y) *  erosion_level(x, y-1)
        end
    end

    def erosion_level(x, y)
        (geologic_index(x, y) + @depth) % 20183
    end

    def type(x, y)
        case erosion_level(x, y) % 3
        when 0
            :rocky
        when 1
            :wet
        when 2
            :narrow
        end
    end

    def risk_level_by_type(type)
        case type
        when :rocky
            0
        when :wet
            1
        when :narrow
            2
        end
    end

    def risk_level_by_erosion_level(el)
        el % 3
    end
end