require "./cart.rb"

#part 1

def tile_to_sym(tile)
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
carts.each { |cart| p cart }

ticks = 0
loop do
    crashed_cart = []
    p "============ Tick ##{ticks} ============"
    carts.each do |cart|
        next_location = cart.determine_next_location
        cart.tick(tile_to_sym(map[next_location[1]][next_location[0]]), next_location)
        crashed_cart = carts.select {|c| cart.id > c.id && cart.location == c.location}
        ticks += 1
        p cart
    end
    if crashed_cart.length > 0
        p "Carts crashed at #{crashed_cart[0].location}!"
        break
    end
end
#p carts