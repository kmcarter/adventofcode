class MarbleGame
    def initialize(num_players, last_marble)
        @last_marble = last_marble
        @circle = [0]
        @players = []
        (0..num_players).each { |id| @players << Player.new(id) }
    end

    def play
        (1..@last_marble+1).each do |i|
            take_turn(i)
        end
    end

    def players
        @players
    end

    def take_turn(marble)
        #p "#{@circle.join(" ")} -->"
        if marble % 23 == 0
            @circle.rotate!(-7)
            @players[marble % @players.length].score(marble + @circle[0])
            @circle.slice!(0,1)
        else
            @circle.rotate!(2)
            @circle.insert(0, marble)
        end
        #p @circle.join(" ")
    end
end