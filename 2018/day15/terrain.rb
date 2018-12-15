class Terrain
    def initialize(terrain)
        @terrain = terrain.is_a?(String) ? Terrain.to_sym(terrain) : terrain
    end

    def ==(b)
        if b.is_a?(String)
            b == @terrain.to_s
        elsif b.is_a?(Symbol)
            b == @terrain
        end
    end

    def set(terrain)
        if @terrain != :wall
            @terrain = terrain.is_a?(String) ? Terrain.to_sym(terrain) : terrain
        end
        self
    end

    def to_s
        return "G" if @terrain == :goblin
        return "E" if @terrain == :elf
        return "." if @terrain == :floor
        return "#" if @terrain == :wall
    end

    def self.to_sym(str)
        return :goblin if str == "G"
        return :elf if str == "E"
        return :floor if str == "."
        return :wall if str == "#"
    end
end