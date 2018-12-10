class MarbleGame
    def initialize(num_players, last_marble)
        @last_marble = last_marble
        @circle = [0]
        @players = []
        (0..num_players).each { |id| @players << Player.new(id+1) }
    end

    def play
        (1..@last_marble).each do |i|
            take_turn(i, @players[0])
            @players.rotate!(1)
        end
    end

    def players
        @players
    end

    def take_turn(marble, player)
        if marble % 23 == 0
            @circle.rotate!(-7)
            #p @circle.join(" ")
            player.score(marble + @circle[0])
            @circle.slice!(0,1)
        elsif @circle.length > 0
            #p "#{@circle.join(" ")} -->"
            @circle.rotate!(2)
            @circle.insert(0, marble)
        else
            @circle << marble
        end
    end
end