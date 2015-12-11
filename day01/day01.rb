floor = 0
input = File.open('input.txt').read
floor =+ input.count('(') - input.count(')')
p floor