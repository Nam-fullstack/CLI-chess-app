# frozen_string_literal: true

require_relative 'piece'

# move mechanics for King
class King < Piece
    def initialize(board, attributes)
        super(board, attributes)
        @symbol = " \u2654 "
    end

    private 

    def move_mechanics
        [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]]
    end
end