require "./cart.rb"

#part 1

def tile_to_sym(tile)
    if tile == "<"
        return :left
    elsif tile == ">"
        return :right
    elsif tile == "^"
        return :up
    elsif tile == "v"
        return :down
    elsif tile == "-"
        return :straight_horz
    elsif tile == "|"
        return :straight_vert
    elsif tile == "\\"
        return :left_curve
    elsif tile == "/"
        return :right_curve
    elsif tile == "+"
        return :intersection
    else
        return tile
    end
end

map = File.open("input.txt").read.split("\n")
carts = []

map.map! do |line|
    line.chars.to_a
end

#remember! this map is y,x NOT x,y (convenient for cart turn order tho)
map.each_with_index do |line, y|
    line.each_with_index do |point, x|
        tile = point.match(/([<>v^])/)
        if tile != nil
            carts << Cart.new(carts.length, [x,y], tile_to_sym(tile[0]))
        end
    end
end

map.each { |line| p line.join }
#p carts

ticks = 0
loop do
    crashed_cart = []
    #p "============ Tick ##{ticks} ============"
    carts.each do |cart|
        next_location = cart.determine_next_location
        cart.tick(tile_to_sym(map[next_location[1]][next_location[0]]), next_location)
        crashed_cart = carts.select {|c| cart.id > c.id && cart.location == c.location}
        ticks += 1
    end
    if crashed_cart.length > 0
        p "Carts crashed at #{crashed_cart[0].location}!"
        break
    end
end
#p carts