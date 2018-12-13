require "./track.rb"

#part 1

input = File.open("input.txt").read

track = Track.new(input)
track.print
track.push_carts

#track.carts.each { |cart| p cart }
#p carts