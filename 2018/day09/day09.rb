require "./game.rb"

num_players = 478
last_marble = 71240 * 100

game = MarbleGame.new(num_players, last_marble)

game.play
max_score = game.players.max
winner = game.players.index(max_score) + 1
p "Player #{winner} won with score of #{max_score}"