class TreeReader
    def initialize(input)
        @input = input
        @index = 0
    end

    def read_node
        node = Node.new
        #p "Node index #{@index}"
        num_children = @input[@index].to_i
        @index += 1
        num_metadata = @input[@index].to_i
        @index += 1

        if num_children > 0
            (1..num_children).each do |i|
                node.add_child(read_node)
            end
        end
        if num_metadata > 0
            (1..num_metadata).each do |i| 
                node.add_metadata(@input[@index])
                @index += 1
            end
        end
        return node
    end
end