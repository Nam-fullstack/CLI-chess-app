require_relative 'piece'

class Rook < Piece
    def initialize(board, attributes)
        super(board, attributes)
        @symbol = " \u265C "
    end

    def move_mechanics
        [[1, 0], [-1, 0], [0, 1], [0,-1]]
    end
end