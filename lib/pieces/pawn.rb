# frozen_string_literal: true

require_relative '../board'

# move mechanics for pawn
class Pawn < Piece
    def iniatilize(board, attributes)
        super(board, attributes)
        @symbol = " \u265F "
        @moved = false
        @en_passant = false
    end

    def update_location(row, column)
        update_en_passant(row)
        @location = [row, column]
        @moved = true
    end

    def find_possible_moves(board)
        [single_advance(board), double_advance(board)].compact
    end

    # defines capture mechanics for pawns (on diagonal to left or right)
    def find_possible_captures(board)
        file = @location[1]
        [
            basic_capture(board, file - 1),
            basic_capture(board, file + 1),
            en_passant_capture(board)
        ].compact
    end

    # determines the direction that white[up] & black[down] pawns move
    def rank_direction
        color == :white ? -1 : 1
    end
    
    # determines if pawn is in the right rank to capture en passant
    def en_passant_rank?
        rank = location[0]
        (rank == 4 && color == :black) || (rank ==3 && color == :white)
    end

    private

    def single_advance(board)
        move = [@location[0] + rank_direction, @location[1]]
        return move unless board.data[move[0]][move[1]]
    end

    def double_advance(board)
        double_rank = @location[0] + (rank_direction * 2)
        bonus = [double_rank, @location[1]]
        return bonus unless invalid_bonus_move?(board, bonus)
    end

    def invalid_bonus_move?(board, bonus)
        first_move = single_move(board)
        return true unless first_move
        @move || board.data[bonus[0]][bonus[1]]
    end

    
end
