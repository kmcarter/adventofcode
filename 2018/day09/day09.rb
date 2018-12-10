require "./game.rb"
require "./player.rb"

input = File.open("example.txt").read.split(" ")
num_players = input[0].to_i
last_marble_points = input[6].to_i

game = MarbleGame.new
p game.take_turn
p game.take_turn
p game.take_turn
p game.take_turn
p game.take_turn