class Player
    def initialize(id)
        @id = id
        @score = 0
    end

    def id
        @id
    end

    def get_score
        @score
    end

    def score(score)
        @score += score
    end
end