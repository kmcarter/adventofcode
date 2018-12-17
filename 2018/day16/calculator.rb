class Calculator
    attr_reader :operations
    
    def initialize
        @all_opcodes = [ "addr", "addi", "mulr", "muli", "banr", "bani", "borr", "bori", "setr", "seti", "gtir", "gtri", "gtrr", "eqir", "eqri", "eqrr" ]
        @opcodes = ["addi", "mulr", "muli", "borr", "bori", "gtir"]
        #@operations = Array.new(16, nil)
        @operations = ["bani", "addr", nil, nil, "gtri", "banr", nil, "eqri", "seti", "eqrr", nil, "setr", "eqir", nil, "gtrr", nil]
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

    def match_operations(operation_matches, registers, inst, expected)
        if operation_matches.length >= 2
            p "Possible combos for opcode #{inst[0]}: #{operation_matches}"
        elsif operation_matches.length == 1
            @operations[inst[0]] = operation_matches[0]
            @opcodes.delete(operation_matches[0])
            #p "New operation found. #{operation_matches} == #{inst[0]}"
        elsif operation_matches.length == 0
            p "No matches!? Registers = #{registers}, instructions = #{inst}, expected = #{expected}"
        else
            #p "#{operation_matches.length} operations match"
        end
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