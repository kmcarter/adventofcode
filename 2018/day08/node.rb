class Node

    def initialize
        @children = []
        @metadata = []
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