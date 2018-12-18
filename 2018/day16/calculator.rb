class Calculator
    attr_reader :operations
    
    def initialize
        @opcodes = [ "addr", "addi", "mulr", "muli", "banr", "bani", "borr", "bori", "setr", "seti", "gtir", "gtri", "gtrr", "eqir", "eqri", "eqrr" ]
        #@opcodes = ["addi", "mulr", "muli", "borr", "bori", "gtir"]
        @operations = ["bani", "addr", "mulr", "addi", "gtri", "banr", "borr", "eqri", "seti", "eqrr", "bori", "setr", "eqir", "muli", "gtrr", "gtir"]
        #@operations = ["bani", "addr", nil, nil, "gtri", "banr", nil, "eqri", "seti", "eqrr", nil, "setr", "eqir", nil, "gtrr", nil]
    end

    def try_all(registers, inst, expected)
        operation_matches = []
        
        #puts "Checking opcodes #{@opcodes}"
        @opcodes.each do |opcode|
            result = public_send(opcode, registers, inst)
            if (result <=> expected) == 0
                operation_matches << opcode
            end
            #p "#{opcode}: #{result}"
        end

        #p "# of different outcomes = #{operation_matches.length}"
        operation_matches
    end

    def match_operations(possible_matches)
        possible_matches.each_with_index do |op, i|
            if op.length == 1
                @operations[i] = op[0]
                break
            end
        end
        possible_matches.map! do |possibilities|
            possibilities.select {|match| !@operations.include? match}
        end
        possible_matches.each_with_index {|op,i| puts "#{i}: #{op}" }
        @operations
    end

    def match_operations2
        found_val = nil
        @operation_matches.each do |key, value|
            if value.length == 1
                @operations[value[0]] = key
                found_val = value[0]
                break
            end
        end
        @operation_matches.each { |key, value| @operation_matches[key] = value.select {|i| i != found_val } }
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