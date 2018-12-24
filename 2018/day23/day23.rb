require "./nanobot.rb"

#part 1
bots = []
input = File.open("input.txt").read.strip.split("\n")
input.each do |row|
    data = row.split(/[,<>=]/)
    bots << Nanobot.new(data[2].to_i, data[3].to_i, data[4].to_i, data[7].to_i)
end

bots.sort! {|x,y| y.r <=> x.r }

bots_in_range = 0
bots.each do |bot|
    #p "The nanobot at #{bot.x},#{bot.y},#{bot.z} is distance #{bots[0].distance_from(bot)} away, so is it in range? #{bots[0].in_range?(bot)}"
    bots_in_range += 1 if bots[0].in_range?(bot)
end
p "Bots in range = #{bots_in_range}"