class MarbleGame
    def initialize(num_players, last_marble)
        @last_marble = last_marble
        @circle = []
        @players = []
        (0..num_players).each { |id| @players << Player.new(id+1) }
    end

    def play
        (0..@last_marble).each do |i|
            take_turn(i, @players[0])
            @players.rotate!(1)
        end
    end

    def players
        @players
    end

    def take_turn(marble_index, player)
        
        if marble_index != 0 && marble_index % 23 == 0
            @circle.rotate!(-7)
            #p @circle.join(" ")
            player.score(marble_index + @circle[0])
            @circle.slice!(0,1)
        elsif @circle.length > 0
            #p "#{@circle.join(" ")} -->"
            @circle.rotate!(2)
            @circle.insert(0, marble_index)
        else
            @circle << marble_index
        end
    end
end