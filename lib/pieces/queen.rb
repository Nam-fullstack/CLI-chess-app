require_relative '../board'

class Queen < Piece
    def iniatilize(board, attributes)

        @symbol = " \u265B "
    end

    def move_mechanics
        [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]]
    end
end