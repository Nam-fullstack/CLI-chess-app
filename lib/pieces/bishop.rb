# frozen_string_literal: true

require_relative 'piece'

# Move mechanics for bishop
class Bishop < Piece
    def initialize(board, attributes)
        super(board, attributes)
        @symbol = color == :white ? " \u2657 " : " \u265D "
    end

    private

    def move_mechanics
        [[1,1], [1, -1], [-1, 1], [-1, -1]]
    end
end
