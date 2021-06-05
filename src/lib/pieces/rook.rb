# frozen_string_literal: true

require_relative 'piece'

# move mechanics for rook
class Rook < Piece
  def initialize(board, attributes)
    super(board, attributes)
    @symbol = " \u265C "
  end

  private

  def move_mechanics
    [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end
