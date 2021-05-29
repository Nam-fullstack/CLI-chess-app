# frozen_string_literal: true

require_relative 'piece'

# move mechanics for queen
class Queen < Piece
    def initialize(board, attributes)
        super(board, attributes)
        @symbol = " \u265B "
    end

    private

    def move_mechanics
        [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]]
    end
end