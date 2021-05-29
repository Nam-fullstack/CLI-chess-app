# frozen_string_literal: true

require_relative 'piece'

# move mechanics for queen
class Queen < Piece
    def initialize(board, attributes)
        super(board, attributes)
        @symbol = color == :white ? " \u2655 " : " \u265B "
    end

    # def symbol_color
    #     color == :white ? " \u2655 " : " \u265B "
    # end
    private

    def move_mechanics
        [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]]
    end
end