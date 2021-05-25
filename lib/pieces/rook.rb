require_relative '../board'

class Rook
    def initialize(board, attributes)

        @symbol = " \u265C "
    end

    def move_mechanics
        [[1, 0], [-1, 0], [0, 1], [0,-1]]
    end
end