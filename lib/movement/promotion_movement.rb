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

    def remove_pawn_observer
        location = @board.active_piece.location
        @board.delete_observer(@board.data[location[0]][location[1]])
    end

    def update_promotion_coordinates(piece)
        @board.data[row][column] = piece
    end

    def update_board_active_piece(piece)
        @board.active_piece = piece
    end

    def select_promotion_piece
        choice = gets.strip
        return choice if choice.match?(/^[1-4]$/)

        puts 'Input error! Please enter 1, 2, 3, or 4.'
        select_promotion_piece
    end

    def create_promotion_piece(choice)
        color = @board.active_piece.color
        case choice.to_i
        when 1
            Queen.new(@board, { color: color, location: [row, column] })
        when 2
            Bishop.new(@board, { color: color, location: [row, column] })
        when 3
            Knight.new(@board, { color: color, location: [row, column] })
        else
            Rook.new(@board, { color: color, location: [row, column] })
        end
    end

    def pawn_promotion_choices
        <<~HEREDOC
            To select the piece you wish to promote your pawn to, enter it's corresponding number:
            \e[36m[1]\e[0m for a \e[1m\u2655 Queen \e[0m
            \e[36m[2]\e[0m for a \e[1m\u2657 Bishop \e[0m
            \e[36m[3]\e[0m for a \e[1m\u2658 Knight \e[0m
            \e[36m[4]\e[0m for a \e[1m\u2656 Rook \e[0m

        HEREDOC
    end
end
