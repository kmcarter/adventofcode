require "./cart.rb"

class Track
    attr_reader :map
    attr_reader :carts
    INTERSECTION_DIRS = [ :left, :straight, :right ]

    def initialize(input)
        @map = input.split("\n")
        @map = @map.map do |line|
            line.chars.to_a
        end

        @carts = []
        #remember! this map is y,x NOT x,y (convenient for cart turn order tho)
        @map.each_with_index do |line, y|
            line.each_with_index do |point, x|
                tile = point.match(/([<>v^])/)
                if tile != nil
                    if tile[0] == "<" || tile[0] == ">"
                        line[x] = Track.sym_to_tile(:straight_horz)
                    else
                        line[x] = Track.sym_to_tile(:straight_vert)
                    end
                    @carts << Cart.new(@carts.length, [x,y], Track.tile_to_sym(tile[0]))
                end
            end
        end
    end

    def push_carts
        ticks = 0
        loop do
        #(0..10).each do |ticks|
            crashed_carts = []
            @carts.sort! {|a,b| a.location <=> b.location}
            
            #p "============ Tick ##{ticks} ============"
            @carts.each do |cart|
                next_location = cart.determine_next_location
                #p "Current location = #{cart.location} --> #{next_location}"
                next_tile = Track.tile_to_sym(@map[next_location[1]][next_location[0]])
                if next_tile == :intersection
                    next_tile = convert_intersection(cart.num_turns, cart.direction)
                    cart.num_turns += 1
                end
                cart.tick(next_tile, next_location)
                #p "After moving: #{cart.location}"
                crashed_carts = detect_collision(cart.location)
                break if crashed_carts.length > 1
                ticks += 1
                #p cart
            end
            #print
            if crashed_carts.length > 1
                print
                p "Carts crashed at #{crashed_carts[0].location}!"
                break
            end
        end
    end

    def crash_carts
        ticks = 0
        loop do
        #(0..10).each do |ticks|
            crashed_carts = []
            @carts.select!{|c| !c.crashed }
            @carts.sort! {|a,b| a.location <=> b.location}
            
            if @carts.length == 1
                break
            end

            #p "============ Tick ##{ticks} ============"
            @carts.each do |cart|
                next_location = cart.determine_next_location
                #p "Current location = #{cart.location} --> #{next_location}"
                next_tile = Track.tile_to_sym(@map[next_location[1]][next_location[0]])
                if next_tile == :intersection
                    next_tile = convert_intersection(cart.num_turns, cart.direction)
                    cart.num_turns += 1
                end
                cart.tick(next_tile, next_location)
                #p "After moving: #{cart.location}"

                crashed_carts = detect_collision(cart.location)
                if crashed_carts.length > 1
                    print
                    p "Carts crashed at #{crashed_carts[0].location}!"
                    crashed_carts.each { |cart| cart.crashed = true }
                end

                ticks += 1
                p cart
            end
            #print
        end
    end

    def detect_collision(location)
        matching_carts = @carts.select {|cart| cart.location == location}
        return matching_carts
    end

    def print
        temp_map = Marshal.load(Marshal.dump(@map))
        temp_map.each_with_index do |line,y|
            line.each_with_index do |cell,x|
                matching_carts = detect_collision([x,y])
                if matching_carts.length > 1
                    line[x] = "X"
                elsif matching_carts.length == 1
                    line[x] = Track.sym_to_tile(matching_carts[0].direction)
                end
            end
            puts line.join
        end
    end

    def self.tile_to_sym(tile)
        return :left if tile == "<"
        return :right if tile == ">"
        return :up if tile == "^"
        return :down if tile == "v"
        return :straight_horz if tile == "-"
        return :straight_vert if tile == "|"
        return :left_curve if tile == "\\"
        return :right_curve if tile == "/"
        return :intersection if tile == "+"
        return tile
    end

    def self.sym_to_tile(sym)
        return "<" if sym == :left
        return ">" if sym == :right
        return "^" if sym == :up
        return "v" if sym == :down
        return "-" if sym == :straight_horz
        return "|" if sym == :straight_vert
        return "\\" if sym == :left_curve
        return "/" if sym == :right_curve
        return "+" if sym == :intersection
        return sym
    end

    private
    def convert_intersection(num_turns, direction)
        decision = INTERSECTION_DIRS[num_turns % 3]

        #p "Direction = #{direction}, decision = #{decision}"
        if direction == :right || direction == :left
            new_tile = :straight_horz
            new_tile = :left_curve if decision == :right
            new_tile = :right_curve if decision == :left
        else
            new_tile = :straight_vert
            new_tile = :right_curve if decision == :right
            new_tile = :left_curve if decision == :left
        end
        #p "Intersection decision #{decision} (num turns = #{num_turns}) = new tile #{new_tile}"
        new_tile
    end
end