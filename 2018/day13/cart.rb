class Cart
    attr_reader :id
    attr_reader :location
    attr_reader :direction

    def initialize(id, location, direction)
        @id = id
        @location = location
        @direction = direction
        @intersection_dirs = [ :left, :straight, :right ]
        @num_turns = 0
    end

    def tick(next_tile, next_location)
        old_direction = @direction
        old_location = @location
        @direction = determine_direction(next_tile)
        @location = next_location
        #p "Cart ##{@id} went from #{old_location} heading #{old_direction} to #{@location} heading #{@direction}"
    end

    def determine_next_location
        if @direction == :left
            next_location = [ @location[0] - 1, @location[1] ]
        elsif @direction == :right
            next_location = [ @location[0] + 1, @location[1] ]
        elsif @direction == :up
            next_location = [ @location[0], @location[1] - 1 ]
        elsif @direction == :down
            next_location = [ @location[0], @location[1] + 1 ]
        end
    end

    private
    def determine_direction(next_tile)
        next_tile = convert_intersection if next_tile == :intersection
        
        if @direction == :left
            if next_tile == :left_curve
                return :up
            elsif next_tile == :right_curve
                return :down
            else
                return @direction
            end
        elsif @direction == :right
            if next_tile == :left_curve
                return :down
            elsif next_tile == :right_curve
                return :up
            else
                return @direction
            end
        elsif @direction == :up
            if next_tile == :left_curve
                return :left
            elsif next_tile == :right_curve
                return :right
            else
                return @direction
            end
        elsif @direction == :down
            if next_tile == :left_curve
                return :right
            elsif next_tile == :right_curve
                return :left
            else
                return @direction
            end
        else
            return @direction
        end
    end

    private
    def convert_intersection
        decision = @intersection_dirs[@num_turns % 3]
        @num_turns += 1

        if decision == :right
            if @direction == :right || @direction == :left
                return :left_curve
            else
                return :right_curve
            end
        elsif decision == :left
            if @direction == :right || @direction == :left
                return :right_curve
            else
                return :left_curve
            end
        else
            if @direction == :right || @direction == :left
                return :straight_horz
            else
                return :straight_vert
            end
        end
    end

    def will_collide?
    end
end