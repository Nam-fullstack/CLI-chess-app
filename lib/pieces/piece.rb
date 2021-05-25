
require_relative '../board'

class Piece
    attr_reader :color, :location, :moves, :moved, :captures, :symbol

    def initialize(board, attributes)
        @color = attributes[:color]
        @location = attributes[:location]
        @captures = []
        @moved = false
        @symbol = nil
        board.add_observer(self)
    end

end