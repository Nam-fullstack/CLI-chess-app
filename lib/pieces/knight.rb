
class Knight
    def initialize(board, usermove)

        @symbol = " \u265E "
        @captures = []
    end

    def move_mechanics
        [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
    end
end