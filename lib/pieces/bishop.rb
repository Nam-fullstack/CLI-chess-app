require_relative '../board'

# Move mechanics for bishop
class Bishop < Piece
    def initialize(board, attributes)

        @symbol = " \u265D "
    end

    private

    def move_mechanics
        [[1,1], [1, -1], [-1, 1], [-1, -1]]
    end
end
