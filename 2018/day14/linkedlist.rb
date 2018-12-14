#shamefully stolen from https://tqdev.com/2018-doubly-linked-circular-list-in-ruby
class DoublyLinkedCircularList
    attr_reader :length

    class Node
        attr_accessor :previous
        attr_accessor :next
        attr_reader   :value

        def initialize(_value)
            @previous = nil
            @next = nil
            @value = _value
        end

        def get
            self
        end

        def to_s
            @value.to_s
        end
    end

    def initialize
        @head = nil
        @length = 0
    end

    def get_by_index(i)
        node = @head
        if (i < 0)
            i.abs.times do
                node = node.previous
            end
        else
            i.abs.times do
                node = node.next
            end
        end
        node
    end

    def append(value)
        node = Node.new(value)
        if @head.nil?
            @head = node
            node.previous = node
            node.next = node
        else
            node.previous = @head.previous
            node.next = @head
        end
        node.previous.next = node
        node.next.previous = node
        @length += 1
        self
    end

    def remove
        return self if @head.nil?
        node = @head.previous
        node.next = @head.next
        node.next.previous = node
        @head = @head == @head.next ? nil : @head.previous
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
                str += node.to_s
                node = node.next
                break if node == @head
                str += ','
            end
        end
        str += ']'
        str
    end
end