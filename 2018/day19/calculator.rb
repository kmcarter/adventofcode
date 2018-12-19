class Calculator

    def initialize(initial_register_vals)
        @register = initial_register_vals
    end

    def run(ip, instructions)
        loop do
            if instructions[ip] == nil
                break
            end
            register_before = @register
            @register[0] = ip
            @register = public_send(instructions[ip][0], @register, instructions[ip])
            puts "ip=#{ip} #{register_before} #{instructions[ip]} #{@register}}"
            ip = @register[0] + 1
        end
        @register
    end
    
    def addr(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]] + registers[inst[2]]
        result
    end

    def addi(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        #p "addi stores into register C (idx #{inst[3]}) the result (#{registers[inst[1]] + inst[2]}) of adding register A (which has a value of #{registers[inst[1]]}) and value B (#{inst[2]})"
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
        result[inst[3]] = registers[inst[1]] * inst[2]
        result
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