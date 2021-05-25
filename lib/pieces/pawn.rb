require_relative '../board'

class Pawn
    def iniatilize(board, attributes)

        @symbol = " \u265F "
        @moved = fales
    end

    def single_advance(board)
        [0, 1]
    end

    def double_advance(board)
        [0, 2]
    end
end
