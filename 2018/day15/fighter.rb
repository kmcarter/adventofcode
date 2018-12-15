require "./map.rb"

class Fighter
    attr_reader :location

    def initialize(type, location, turn_order, map)
        @attack_power = 3
        @health_points = 200
        @alive = true
        @type = type
        @location = location
        @turn_order = turn_order
        @map = map
    end

    def self.type_to_str(type)
        return "G" if type == :goblin
        return "E" if type == :elf
    end

    def self.str_to_type(str)
        return :goblin if str == "G"
        return :elf if str == "E"
    end

    def take_turn
        p find_enemies
        move if find_enemies.length == 0
        attack if find_enemies_in_range.length > 0
    end

    def find_enemies
        enemy_type = @type == :elf ? :goblin : :elf
        @map.get_unit_locations(enemy_type)
    end

    def find_enemies_in_range
        [1]
    end

    def move
        p "Moved!"
    end

    def attack
        p "Attacked!"
    end
end