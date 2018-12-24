class Nanobot
    attr_reader :x
    attr_reader :y
    attr_reader :z
    attr_reader :r

    def initialize(x, y, z, r)
        @x = x
        @y = y
        @z = z
        @r = r
    end

    def distance_from(bot)
        sum = 0
        sum += (bot.x - @x).abs
        sum += (bot.y - @y).abs
        sum += (bot.z - @z).abs
        sum
    end

    def in_range?(bot)
        distance_from(bot) <= @r
    end
end