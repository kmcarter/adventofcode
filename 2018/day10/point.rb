class Point
    def initialize(position, velocity)
        @position = position
        @velocity = velocity
        @current_position = position
    end

    def position(seconds = nil)
        if seconds != nil
            @current_position = [ @position[0] + @velocity[0] * seconds, @position[1] + @velocity[1] * seconds ]
        end
        @current_position
    end
end