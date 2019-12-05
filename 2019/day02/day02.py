from pathlib import Path


target = 19690720
input_file = Path('./2019/day02/input.txt')
program = [line.strip().split(',') for line in input_file.open()]
program = [int(val) for val in program[0]]
print(program)

def process_opcode(pointer):
    opcode = inst[pointer]
    if opcode == 99:
        return 0

    noun = inst[pointer+1]
    verb = inst[pointer+2]
    output_idx = inst[pointer+3]

    if opcode == 1:
        inst[output_idx] = inst[noun] + inst[verb]
    elif opcode == 2:
        inst[output_idx] = inst[noun] * inst[verb]
    else:
        print("oops")
    return pointer + 4

input = -1
output = 0
while output != target and input <= 9999:
    input += 1
    inst = program.copy()
    inst[1] = input // 100
    inst[2] = input % 100
    print(f"Attempting noun {inst[1]} and verb {inst[2]}")
    
    instr_pointer = 0
    instr_pointer = process_opcode(instr_pointer)
    #print(inst)
    while instr_pointer > 0:
        instr_pointer = process_opcode(instr_pointer)
    print(f"Final: {inst}")
    output = inst[0]

print(input)