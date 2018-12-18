spring = [500, 0]
map = {}
input = File.open("./example.txt").read.split("\n")
input.map! {|line| line.split(", ")}
p input
input.map! do |coords|
    x = nil
    y = nil
    coords.each do |coord|
        coord_split = coords[0].split("=")
        if coord_split[1].index("..") != nil
            coord_split[1] = coord_split[1].split("..").each {|pole| pole.to_i }
            p coord_split[1]
        else
            coord_split[1] = coord_split[1].to_i
        end

        x = coord_split[1] if coord_split[0] == "x"
        y = coord_split[1] if coord_split[0] == "y"
    end
    [ x, y ]
end
p input

input.each do |coords|
    if coords[0][1].index("..") != nil
        
    elsif coords[1][1].index("..") != nil

    else
        
    end
end