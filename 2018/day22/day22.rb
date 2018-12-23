require "./survey.rb"

#part 1
depth = 3879
target = [8, 713]
survey = Survey.new(depth, target)

#p survey.type(1,1)

survey.map_erosion_levels

#p survey.print_map
p survey.map_risk_levels