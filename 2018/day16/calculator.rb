class Calculator

    def try_all(registers, inst, expected)
        opcodes = [ "addr", "addi", "mulr", "muli", "banr", "bani", "borr", "bori", "setr", "seti", "gtir", "gtri", "gtrr", "eqir", "eqri", "eqrr" ]
        num_different = 0
        
        opcodes.each do |opcode|
            result = public_send(opcode, registers, inst)
            num_different += 1 if (result <=> expected) == 0
            p "#{opcode}: #{result}"
        end

        p "# of different outcomes = #{num_different}"
        num_different
    end
    
    def addr(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]] + registers[inst[2]]
        result
    end

    def addi(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        p "addi stores into register C (idx #{inst[3]}) the result (#{registers[inst[1]] + inst[2]}) of adding register A (which has a value of #{registers[inst[1]]}) and value B (#{inst[2]})"
        result[inst[3]] = registers[inst[1]] + inst[2]
        result
    end

    def mulr(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]] * registers[inst[2]]
        result
    end

    def muli(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        registers[inst[3]] = registers[inst[1]] * inst[2]
        registers
    end

    def banr(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]] & registers[inst[2]]
        result
    end

    def bani(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]] & inst[2]
        result
    end

    def borr(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]] | registers[inst[2]]
        result
    end

    def bori(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]] | inst[2]
        result
    end

    def setr(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]]
        result
    end

    def seti(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = inst[1]
        result
    end

    def gtir(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = inst[1] <=> registers[inst[2]]
        result
    end

    def gtri(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]] <=> inst[2]
        result
    end

    def gtrr(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]] <=> registers[inst[2]]
        result
    end

    def eqir(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = inst[1] == registers[inst[2]] ? 1 : 0
        result
    end

    def eqri(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]] == inst[2] ? 1 : 0
        result
    end

    def eqrr(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]] == registers[inst[2]] ? 1 : 0
        result
    end

end