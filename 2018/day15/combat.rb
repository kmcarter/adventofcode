require "./fighter.rb"
require "./map.rb"

class CombatSimulator
    
    def initialize(input)
        @map = Environment.new(input)
        @units = initialize_units
        @map.reset_map
        
        @map.print
    end

    def play
        @units[0].take_turn
    end

    private
    def initialize_units
        units = []
        turn_order = 0
        @map.each_square do |cell, x, y|
            if cell == :goblin
                units << Fighter.new(:goblin, [x,y], turn_order, @map)
                turn_order += 1
            elsif cell == :elf
                units << Fighter.new(:elf, [x,y], turn_order, @map)
                turn_order += 1
            end
        end
        units
    end

end