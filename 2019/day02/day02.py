from pathlib import Path

input = Path('./2019/day02/input.txt')
inputs = [line.strip().split(',') for line in input.open()]
inst = [int(val) for val in inputs[0]]
print(inst)
#inst = [1,1,1,4,99,5,6,0,99]

def process_opcode(opcode, input1_idx=None, input2_idx=None, output_idx=None):
    if opcode == 99:
        return False
    elif opcode == 1:
        inst[output_idx] = inst[input1_idx] + inst[input2_idx]
    elif opcode == 2:
        inst[output_idx] = inst[input1_idx] * inst[input2_idx]
    else:
        print("oops")
    return True

inst[1] = 12
inst[2] = 2
current_opcode_idx = 0
do_continue = process_opcode(*inst[current_opcode_idx:current_opcode_idx+4])
print(inst)
while do_continue:
    current_opcode_idx += 4
    do_continue = process_opcode(*inst[current_opcode_idx:current_opcode_idx+4])
    print(inst)