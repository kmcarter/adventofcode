require "./fighter.rb"
require "./map.rb"

class CombatSimulator
    
    def initialize(input)
        @map = Environment.new(input)
        @units = initialize_units
        
        @map.print
    end

    def play
        goblins = get_unit_locations(:goblin)
        elves = get_unit_locations(:elf)
        @units[0].take_turn(@units[0].type == :elf ? goblins : elves)
    end

    def get_unit_locations(type)
        locations = []
        @units.each do |unit|
            locations << unit.location if unit.type == type
        end
        locations
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