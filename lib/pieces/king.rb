# frozen_string_literal: true

require_relative 'piece'

# logic for King
class King < Piece
    def initialize(board, attributes)
        super(board, attributes)
        @symbol = " \u265A "
    end

    def find_possible_moves(board)
        moves = move_mechanics.inject([]) do |memo, move|
            memo << create_moves(board.data, move[0], move[1])
        end
        moves += castling_moves(board)
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

    def castling_moves(board)
        castling_moves = []
        rank = location[0]
        castling_moves << [rank, 6] if king_side_castling?(board)
        castling_moves << [rank, 2] if queen_side_castling?(board)
        castling_moves
    end

    def king_side_castling?(board)
        king_side_pass = 5
        empty_files = [6]
        king_side_rook = 7
        unmoved_rook?(board, king_side_rook) &&
            empty_files?(board, empty_files) &&
            !board.king_in_check?(@color) &&
            king_pass_through_safe?(board, king_side_pass)
    end

    def queen_side_castling?(board)
        queen_side_pass = 3
        empty_files = [1, 2]
        queen_side_rook = 0
        unmoved_rook?(board, queen_side_rook) &&
          empty_files?(board, empty_files) &&
          !board.king_in_check?(@color) &&
          king_pass_through_safe?(board, queen_side_pass)
    end

    # checks if King and rook has not moved
    def unmoved_rook?(board, file)
        piece = board.data[location[0]][file]
        return false unless piece

        moved == false && piece.symbol == " \u265C " && piece.moved == false
    end

    def empty_files?(board, files)
        files.none? { |file| board.data[location[0]][file] }
    end

    # determines if King doesn't go through check
    def king_pass_through_safe?(board, file)
        rank = location[0]
        board.data[rank][file].nil? && safe_passage?(board, [rank, file])
    end

    # finds possible moves for opposing color, determines if King's location (passed in) 
    # is included in any of those possible moves
    def safe_passage?(board, location)
        pieces = board.data.flatten(1).compact
        pieces.none? do |piece|
            next unless piece.color != color && piece.symbol != symbol

            moves = piece.find_possible_moves(board)
            moves.include?(location)
        end
    end

    def move_mechanics
        [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]]
    end
end