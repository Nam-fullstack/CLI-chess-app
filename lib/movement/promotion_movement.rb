# frozen_string_literal: true

require_relative 'basic_movement'

# logic for pawn promotion
class PawnPromotionMovement < BasicMovement
    def initialize(board = nil, row = nil, column = nil)
        super
    end

    def update_pieces(board, coordinates)
        @board = board
        @row = coordinates[:row]
        @column = coordinates[:column]
        update_pawn_promotion_moves
    end

    def update_pawn_promotion_moves
        remove_capture_piece_observer if @board.data[row][column]
        remove_pawn_observer
        remove_original_piece
        new_piece = new_promotion_piece
        update_promotion_coordinates(new_piece)
        update_board_active_piece(new_piece)
    end

    def new_promotion_piece
        if @board.mode == :computer && @board.active_piece.color == :black
            create_promotion_piece('1')
        else
            puts pawn_promotion_choices
            choice = select_promotion_piece
            create_promotion_piece(choice)
        end
    end
end