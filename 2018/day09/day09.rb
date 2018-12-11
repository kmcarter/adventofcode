require "./game.rb"
require "./player.rb"

num_players = 17
last_marble = 1104

game = MarbleGame.new(num_players, last_marble)

game.play
winner = game.players.max_by { |player| player.get_score }
p "Player #{winner.id} won with score of #{winner.get_score}"