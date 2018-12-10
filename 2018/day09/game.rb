class MarbleGame
    def initialize
        @circle = []
        @marble_index = -1
        @current_marble_ind = nil
    end

    def take_turn
        @marble_index += 1
        
        if @circle.length > 0
            placement = @current_marble_ind - @circle.length + 2
            p "Placement: #{@current_marble_ind} - #{@circle.length} + 2 = #{placement}"
            @circle.insert(placement, @marble_index)
            @current_marble_ind = placement
        else
            @circle << @marble_index
            @current_marble_ind = 0
        end

        "#{@circle.join(" ")} (current: #{@circle[@current_marble_ind]})"
    end
end