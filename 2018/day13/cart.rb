class Cart
    attr_reader :id
    attr_reader :location
    attr_reader :direction
    attr_accessor :num_turns
    attr_accessor :crashed

    def initialize(id, location, direction)
        @id = id
        @location = location
        @direction = direction
        @num_turns = 0
        @crashed = false
    end

    def tick(next_tile, next_location)
        old_direction = @direction
        old_location = @location
        @direction = determine_direction(next_tile)
        @location = next_location
        #p "Cart ##{@id} went from #{old_location} heading #{old_direction} to #{@location} heading #{@direction}"
    end

    def determine_next_location
        return [ @location[0] - 1, @location[1] ] if @direction == :left
        return [ @location[0] + 1, @location[1] ] if @direction == :right
        return [ @location[0], @location[1] - 1 ] if @direction == :up
        return [ @location[0], @location[1] + 1 ] if @direction == :down
    end

    private
    def determine_direction(next_tile)
        if @direction == :left
            return :up if next_tile == :left_curve
            return :down if next_tile == :right_curve
        elsif @direction == :right
            return :down if next_tile == :left_curve
            return :up if next_tile == :right_curve
        elsif @direction == :up
            return :left if next_tile == :left_curve
            return :right if next_tile == :right_curve
        elsif @direction == :down
            return :right if next_tile == :left_curve
            return :left if next_tile == :right_curve
        end
        return @direction
    end
end