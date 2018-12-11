require "./linkedlist.rb"

class MarbleGame
    def initialize(num_players, last_marble)
        @last_marble = last_marble
        @circle = DoublyLinkedCircularList.new
        @circle.append(0)
        @players = Array.new(num_players, 0)
    end

    def play
        (1..@last_marble).each do |i|
            take_turn(i)
        end
    end

    def players
        @players
    end

    def take_turn(marble)
        if marble % 23 == 0
            @circle.rotate(-6)
            @players[(marble-1) % @players.length] += (marble + @circle.read)
            @circle.remove
        else
            @circle.rotate(2)
            @circle.append(marble)
            @circle.rotate(-1)
        end
        #p "[#{(marble-1) % @players.length + 1}] #{@circle}"
    end
end