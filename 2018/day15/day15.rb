require "./combat.rb"
input = File.open("example.txt").read
simulator = CombatSimulator.new(input)
simulator.play