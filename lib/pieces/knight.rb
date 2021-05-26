require_relative 'piece'

class Knight < Piece
    def initialize(board, attributes)
        super(board, attributes)
        @symbol = " \u265E "
        @captures = []
    end

    def move_mechanics
        [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
    end
end