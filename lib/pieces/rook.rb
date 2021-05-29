# frozen_string_literal: true

require_relative 'piece'

# move mechanics for rook
class Rook < Piece
    def initialize(board, attributes)
        super(board, attributes)
        @symbol = color == :white ? " \u2656 " : " \u265C "
    end

    private

    def move_mechanics
        [[1, 0], [-1, 0], [0, 1], [0,-1]]
    end
end