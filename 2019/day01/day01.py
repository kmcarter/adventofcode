from pathlib import Path

input = Path('./2019/day01/input.txt')
input_masses = [int(line) for line in input.open()]
total_mass = 0

for mass in input_masses:
    total_mass += mass // 3 - 2

print(total_mass)