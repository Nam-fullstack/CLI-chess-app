require_relative 'piece'

class Queen < Piece
    def iniatilize(board, attributes)
        super(board, attributes)
        @symbol = " \u265B "
    end

    def move_mechanics
        [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]]
    end
end