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

    def initial_positioning
        initial_row(:white, 7)
        initial_row(:black, 0)
        initial_pawn_row(:white, 6)
        initial_pawn_row(:black, 1)
        @white_king = @data[7][4]
        @black_king = @data[0][4]
    end
end