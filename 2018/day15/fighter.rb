require "./map.rb"

class Fighter
    attr_reader :location
    attr_reader :type

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

    def take_turn(enemy_locations)
        move if find_move_target(enemy_locations).length > 0
        #attack if find_enemies_in_range.length > 0
    end

    def move
        p "Moved!"
    end

    def attack
        p "Attacked!"
    end

    private
    def find_move_target(enemy_locations)
        adjacent_enemy_squares = find_adjacent_enemy_squares(enemy_locations)
        p adjacent_enemy_squares
        reachable_squares = filter_reachable_squares(adjacent_enemy_squares)
    end

    private
    def find_adjacent_enemy_squares(enemy_locations)
        adjacent_enemy_squares = []
        enemy_locations.each do |enemy|
            adjacents = [
                @map.up(enemy),
                @map.down(enemy),
                @map.left(enemy),
                @map.right(enemy)
            ]
            p adjacents
            adjacents.each { |loc| adjacent_enemy_squares << loc if @map.terrain_moveable?(loc) }
        end
        adjacent_enemy_squares.uniq
    end

    private
    def filter_reachable_squares(adjacent_enemy_squares)
        adjacent_enemy_squares.each do |loc|
            distance = @map.distance_from(@location, loc)
        end
    end
end