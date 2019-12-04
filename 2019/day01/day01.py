from pathlib import Path

input = Path('./2019/day01/input.txt')
input_masses = [int(line) for line in input.open()]
total_mass = 0

def calc_fuel(mass):
    fuel = mass // 3 - 2
    return 0 if fuel < 0 else fuel

for mass in input_masses:
    fuel = calc_fuel(mass)
    while fuel > 0:
        total_mass += fuel
        fuel = calc_fuel(fuel)

print(total_mass)