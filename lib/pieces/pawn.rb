require_relative '../board'

# move mechanics for pawn
class Pawn < Piece
    def iniatilize(board, attributes)
        super(board, attributes)
        @symbol = " \u265F "
        @moved = false
    end

    private

    def single_advance(board)
        [0, 1]
    end

    def double_advance(board)
        [0, 2]
    end
end
