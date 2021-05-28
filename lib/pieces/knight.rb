require_relative 'piece'

# move mechanics for knight
class Knight < Piece
    def initialize(board, attributes)
        super(board, attributes)
        @symbol = " \u265E "
        @captures = []
    end

    def find_possible_moves(board)
        possible_moves = []
        move_mechanics.each do |move|
            rank = @location[0] + move [0]
            file = @location[1] + move [1]
            next unless valid_location?(rank, file)

            possible_moves << [rank, file] if opposing_piece?(rank, file, board.data)
        end
        @captures = possible_moves
    end

    def find_possible_captures(board)
        possible_captures = []
        move_mechanics.each do |move|
            rank = @location[0] + move[0]
            file = @location[1] + move[1]
            next unless valid_location?(rank, file)

            possible_captures << [rank, file] if opposing_piece?(rank, file, board.data)
        end
        @captures = possible_captures
    end

    private

    def move_mechanics
        [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
    end
end