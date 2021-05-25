

# Move mechanics for bishop
class Bishop
    def initialize(board, usermove)
        
        @symbol = " \u265D "
    end

    private

    def move_mechanics
        [[1,1], [1, -1], [-1, 1], [-1, -1]]
    end
end
