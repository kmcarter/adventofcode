require "./game.rb"
require "./player.rb"

num_players = 10
last_marble = 1618

game = MarbleGame.new(num_players, last_marble)

game.play
winner = game.players.max_by { |player| player.get_score }
p "Player #{winner.id} won with score of #{winner.get_score}"