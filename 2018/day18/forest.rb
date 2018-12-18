class Forest

    def initialize(input)
        @map = input
        @count_results = []
        print
    end

    def count_trees(minute = nil)
        sum_trees = 0
        sum_lumberyards = 0
        @map.each {|row| sum_trees += row.count("|") }
        @map.each {|row| sum_lumberyards += row.count("#") }
        total = sum_trees * sum_lumberyards
        p "Total for minute #{minute}: #{sum_trees} * #{sum_lumberyards} = #{total}"
        #p "169472 appears at #{minute}" if total == 169472
        #p "REPEATED VALUE at minute #{minute} (#{total})" if @count_results.index(total) != nil
        #@count_results << total if @count_results.index(total) == nil
        total
    end

    def transform(minutes)
        1.upto(minutes).each do |minute|
            next_minute
            total = count_trees(minute)
            #@count_results << total if minute < 4
        end
        #p "============================================="
        #print
    end

    def next_minute
        before = Marshal.load(Marshal.dump(@map))
        #p "Before:"
        #before.each {|row| p row.join }
        before.each_with_index do |row, y|
            row.each_with_index do |cell, x|
                surrounding = get_surrounding_area(before, x, y)
                #puts "Area surrounding #{x}, #{y}: #{surrounding}"
                @map[y][x] = get_new_tile(cell, surrounding)
                #p after[x][y]
                #puts "Current tile #{cell} at #{x}, #{y} became #{@map[y][x]}"
            end
        end
        #p "After:"
        #before.each {|row| p row.join }
    end

    def print
        @map.each {|row| p row.join }
    end

    private
    def get_surrounding_area(before, x, y)
        locations = [ [x - 1, y - 1], [x - 1, y], [x - 1, y + 1], [x, y - 1], [x, y + 1], [x + 1, y - 1], [x + 1, y], [x + 1, y + 1] ]
        locations.select! { |coord| coord[0] >= 0 && coord[0] < before[0].length && coord[1] >= 0 && coord[1] < before.length }
        locations.map! do |coord|
            before[coord[1]][coord[0]]
        end
        locations
    end

    private
    def get_new_tile(current, surrounding)
        if current == "."
            num_trees = surrounding.count("|")
            return num_trees >= 3 ? "|" : "."
        elsif current == "|"
            num_lumberyards = surrounding.count("#")
            return num_lumberyards >= 3 ? "#" : "|"
        else
            num_lumberyards = surrounding.count("#")
            num_trees = surrounding.count("|")
            return num_lumberyards >= 1 && num_trees >= 1 ? "#" : "."
        end
    end
end