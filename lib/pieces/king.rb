# frozen_string_literal: true

require_relative 'piece'

# move mechanics for King
class King < Piece
    def initialize(board, attributes)
        super(board, attributes)
        @symbol = " \u265A "
    end

    def find_possible_moves(board)
        moves = move_mechanics.inject([]) do |memo, move|
            memo << create_moves(board.data, move[0], move[1])
        end
        # moves += castling_moves(board)
        moves.compact
    end

    private 

    def create_moves(data, rank_change, file_change)
        rank = @location[0] + rank_change
        file = @location[1] + file_change
        return unless valid_location?(rank, file)
        [rank, file] unless data[rank][file]
    end

    def create_captures(data, rank_change, file_change)
        rank = @location[0] + rank_change
        file = @location[1] + file_change
        return unless valid_location?(rank, file)
        [rank, file] if opposing_piece?(rank, file, data)
    end

    def move_mechanics
        [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]]
    end
end