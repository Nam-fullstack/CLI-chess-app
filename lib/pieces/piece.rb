
require_relative '../board'

class Piece
    attr_reader :color, :location, :moves, :moved, :captures, :symbol

    def initialize(board, attributes)
        @color = attributes[:color]
        @location = attributes[:location]
        @captures = []
        @moves = []
        @moved = false
        @symbol = nil
        board.add_observer(self)
    end

    def update_location(row, column)
        @location = [row, column]
        @move = true
    end


    def create_moves(data, rank_change, file_change)
        rank = @location[0] + rank_change
        file = @location[1] + file_change
        result = []
        while valid_location?(rank, file)
            break if data[rank][file]

            result << [rank, file]
            rank += rank_change
            file += file_change
        end
        result
    end

    # adds capture if piece's move set reaches opponent's piece.
    def create_captures(data, rank_change, file_change)
        rank = @location[0] + rank_change
        file = @location[1] + file_change
        while valid_location?(rank, file)
            break if data[rank][file]
            rank += rank_change
            file += file_change
        end
        [rank, file] if opposing_piece?(rank, file, data)
    end

    # ensures pieces don't go outside the board, only locations inside board are valid.
    def valid_location?(rank, file)
        rank.between?(0, 7) && file.between?(0, 7)
    end

    def opposing_piece?(rank, file, data)
        return unless valid_location?(rank, file)

        piece = data[rank][file]
        piece && piece.color != color
    end
end
