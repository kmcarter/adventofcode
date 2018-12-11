require "./game.rb"
require "./player.rb"

num_players = 478
last_marble = 71240

game = MarbleGame.new(num_players, last_marble)

game.play
winner = game.players.max_by { |player| player.get_score }
p "Player #{winner.id+1} won with score of #{winner.get_score}"