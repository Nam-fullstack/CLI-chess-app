require 'observer'
require_relative 'printables'

class Board
    include Printables
    include Observable
    attr_reader :mode, :white_king, :black_king
    attr_accessor :data, :active_piece, :previous_piece 

    def initialize(data = Array.new(8) { Array.new(8) }, parameters = {} )
        @data = data
        @active_piece = parameters[:active_piece]
        @previous_piece = parameters[:previous_piece]
        @white_king = parameters[:white_king]
        @black_king = parameters[:black_king]
        @mode = parameters[:mode]
    end

    def initial_placement
        initial_row(:white, 7)
        initial_row(:black, 0)
        initial_pawn_row(:white, 6)
        initial_pawn_row(:black, 1)
        @white_king = @data[7][4]
        @black_king = @data[0][4]
        update_all_moves_captures
    end

    def update_active_piece(coordinates)
        @active_piece = data[coordinates[:row]][coordinates[:column]]
    end

    def active_piece_moveable?
        @active_piece.moves.size >= 1 || @active_piece.captures.size >= 1
    end

    # checks to see if piece has any valid moves or captures
    def valid_piece_movement?(coordinates)
        row = coordiantes[:row]
        column = coordinates[:column]
        @active_piece.moves.any?([row, column]) || @active_piece.captures.any?([row, column])
    end

    def valid_piece?(coordinates, color)
        piece = @data[coordinates[:row]][coordinates[:column]]
        piece&.color == color
    end

    def update(coordinates)
        type = movement_type(coordinates)
        movement = Movement.new(type).build
        movement.update_pieces(self, coordinates)
        reset_board_values
    end

    def movement_type(coordinates)
        # if en_passant_capture?(coordinates)
        #     'EnPassant'
        # elsif castling?(coordinates)
        #     'Castling'
        # elsif pawn_promotion?(coordinates)
        #     'PawnPromotion'
        # else
        #     'Basic'
        # end
        return 'Basic'
    end

    def reset_board_values
        @previous_piece = @active_piece
        @active_piece = nil
        changed
        notify_observers(self)
    end

    def random_black_piece
        pieces = @data.flatten(1).compact
        black_pieces = pieces.select do |piece|
            next unless piece.color == :black
            piece.moves.size.positive? || piece.captures.size.positive?
        end
        location = black_pieces.sample.location
        { row: location[0], column: location [1] }
    end     # close random_black_piece

    def update_mode
        @mode = :computer
    end



    # prints the board using Printables module
    def to_s
        print_chess_board
    end

    private

    def initial_pawn_row(color, number)
        8.times do |index|
            @data[number][index] = Pawn.new(self, { color: color, location: [number, index] })
        end
    end

    def initial_row(color, number)
        @data[number] = [
            Rook.new(self, { color: color, location: [number, 0] }),
            Knight.new(self, { color: color, location: [number, 1] }),
            Bishop.new(self, { color: color, location: [number, 2] }),
            Queen.new(self, { color: color, location: [number, 3] }),
            King.new(self, { color: color, location: [number, 4] }),
            Bishop.new(self, { color: color, location: [number, 5] }),
            Knight.new(self, { color: color, location: [number, 6] }),
            Rook.new(self, { color: color, location: [number, 7] })
        ]
    end     # close initial_row

    def update_all_moves_captures
        pieces = @data.flatten(1).compact
        pieces.each { |piece| piece.update(self) }
    end

    def no_legal_moves_captures?(color)
        pieces = @data.flatten[1].compact
        pieces.none? do |piece|
            next unless piece.color == color
            piece.moves.size.positive? || piece.captures.size.posive?
        end
    end
end