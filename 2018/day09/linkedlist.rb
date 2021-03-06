#shamefully stolen from https://tqdev.com/2018-doubly-linked-circular-list-in-ruby
class DoublyLinkedCircularList
    attr_reader :length

    class Node
        attr_accessor :previous
        attr_accessor :next
        attr_reader     :value

        def initialize(_value)
            @previous = nil
            @next = nil
            @value = _value
        end

        def to_s
            @value.to_s
        end
    end

    def initialize
        @head = nil
        @length = 0
    end

    def rotate(steps)
        return self if @head.nil?
        steps.abs.times do
            @head = steps < 0 ? @head.previous : @head.next
        end
        self
    end

    def append(value)
        node = Node.new(value)
        if @head.nil?
            node.previous = node
            node.next = node
        else
            node.previous = @head
            node.next = @head.next
        end
        node.previous.next = node
        node.next.previous = node
        @head = node
        @length += 1
        self
    end

    def remove
        return self if @head.nil?
        node = @head.previous
        node.next = @head.next
        node.next.previous = node
        @head = if @head == @head.next
                    nil
                else
                    @head.previous
                end
        @length -= 1
        self
    end

    def read
        if @head.nil?
            nil
        else
            @head.value
        end
    end

    def to_s
        str = '['
        node = @head
        unless node.nil?
            loop do
                node = node.next
                str += node.to_s
                break if node == @head
                str += ','
            end
        end
        str += ']'
        str
    end
end