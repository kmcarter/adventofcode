class Calculator

    def initialize(initial_register_vals)
        @register = initial_register_vals
    end

    def run(ip_register, instructions)
        iteration_count = 0
        ip = 0
        last_reg1_val = 0
        #opscode_counts_prev = {}
        #opscode_counts = Hash.new(0)
        7200.times.each do
            @register[ip_register] = ip
            register_before = @register

            instruction = instructions[ip]
            #puts "Instruction pointer is #{ip}"

            if instruction == nil
                break
            end

            @register = public_send(instruction[0], @register, instruction)
            #opscode_counts[instructions[@register[ip]][0]] += 1
            puts "ip=#{ip} #{register_before} #{instruction} #{@register}} ##{iteration_count}"
            iteration_count += 1
            ip = @register[ip_register] + 1

            #puts "Register 1 val has reset after #{iteration_count} iterations! register = #{@register}" if @register[1] < last_reg1_val
            last_reg1_val = @register[1]
            #puts "ip set to #{ip}"
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
        result[inst[3]] = inst[1] > registers[inst[2]] ? 1 : 0
        result
    end

    def gtri(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]] > inst[2] ? 1 : 0
        result
    end

    def gtrr(registers, inst)
        result = Marshal.load(Marshal.dump(registers))
        result[inst[3]] = registers[inst[1]] > registers[inst[2]] ? 1 : 0
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