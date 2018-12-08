class Node
    def initialize
        @children = []
        @metadata = []
    end

    def get_value
        value = 0
        if @children.length == 0
            @metadata.each {|num| value += num }
        else
            @metadata.each do |node_index|
                if @children[node_index-1] != nil
                    value += @children[node_index-1].get_value
                end
            end
        end
        value
    end

    def sum_metadata
        sum = 0
        @metadata.each {|num| sum += num }
        @children.each {|child| sum += child.sum_metadata }
        sum
    end

    def add_child(child)
        @children << child
    end

    def add_metadata(metadata)
        @metadata << metadata
    end
end