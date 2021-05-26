require 'observer'
require_relative 'printables'

class Board
    include Printables
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

    # def populate_pieces
    #     populate_rooks
    #     populate_knights
    #     populate_bishops
    #     populate_queens
    #     populate_kings
    #     # castling_check
    #     populate_white_pawns
    #     populate_black_pawns
    # end

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
    end

# *****************************************************************************************************
# MIGHT NEED TO CHANGE THIS LATER IF POSITIONS AREN'T CORRECT
def initial_positioning
    initial_row(:white, 0)
    initial_row(:black, 7)
    initial_pawn_row(:white, 1)
    initial_pawn_row(:black, 6)
    @white_king = @data[0][4]
    @black_king = @data[7][4]
end
# *****************************************************************************************************
end