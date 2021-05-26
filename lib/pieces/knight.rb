require_relative 'piece'

# move mechanics for knight
class Knight < Piece
    def initialize(board, attributes)
        super(board, attributes)
        @symbol = " \u265E "
        @captures = []
    end

    private

    def move_mechanics
        [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
    end
end