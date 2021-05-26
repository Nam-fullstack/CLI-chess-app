require_relative '../board'

class King
    def iniatilize(board, attributes)

        @symbol = " \u265A "
    end

    def move_mechanics
        [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]]
    end
end