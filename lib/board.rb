# frozen_string_literal: true

require_relative 'printables'
require 'observer'

class Board
    include Printables
    include Observable
    attr_reader :mode, :white_king, :black_king
    attr_accessor :data, :active_piece, :previous_piece 

    def initialize(data = Array.new(8) { Array.new(8) }, parameters = {} )
        @mode = parameters[:mode]
        @data = data
        @active_piece = parameters[:active_piece]
        @previous_piece = parameters[:previous_piece]
        @white_king = parameters[:white_king]
        @black_king = parameters[:black_king]
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
    
    def valid_piece?(coordinates, color)
        piece = @data[coordinates[:row]][coordinates[:column]]
        piece&.color == color
    end

    # checks to see if piece has any valid moves or captures
    def valid_piece_movement?(coordinates)
        row = coordinates[:row]
        column = coordinates[:column]
        @active_piece.moves.any?([row, column]) || @active_piece.captures.any?([row, column])
    end

    def update(coordinates)
        type = movement_type(coordinates)
        movement = MovementFactory.new(type).build
        movement.update_pieces(self, coordinates)
        reset_board_values
    end

    def movement_type(coordinates)
        if en_passant_capture?(coordinates)
            'EnPassant'
        elsif castling?(coordinates)
            'Castling'
        elsif pawn_promotion?(coordinates)
            'PawnPromotion'
        else
            'Basic'
        end
    end

    def reset_board_values
        @previous_piece = @active_piece
        @active_piece = nil
        changed
        notify_observers(self)
    end

    def possible_en_passant?
        @active_piece&.captures&.include?(@previous_piece&.location) && en_passant_pawn?
    end

    # determines if King is IN CHECK by seeing opposing piece color can capture location that matches King's location.
    def king_in_check?(color)
        king = color == :white ? @white_king : @black_king
        pieces = @data.flatten(1).compact
        pieces.any? do |piece|
            next unless piece.color != king.color
            piece.captures.include?(king.location)
        end
    end

    def possible_castling?
        @active_piece.symbol == " \u265A " && castling_moves?
    end

    # selects a random black piece if it has any legal moves/captures
    def random_black_piece
        pieces = @data.flatten(1).compact
        black_pieces = pieces.select do |piece|
            next unless piece.color == :black
            piece.moves.size.positive? || piece.captures.size.positive?
        end
        location = black_pieces.sample.location
        { row: location[0], column: location [1] }
    end

    # selects random legal move/capture
    def random_black_move
        possible_moves = @active_piece.moves + @active_piece.captures
        location = possible_moves.sample
        { row: location[0], column: location[1] }
    end

    def update_mode
        @mode = :computer
    end

    # if player has no more legal moves or captures, game over - dependant on conditions:
    # if King is in check or not determines if game is Stalemate or Checkmate
    def game_over?
        return false unless @previous_piece
        previous_color = @previous_piece.color == :white ? :black : :white
        no_legal_moves_captures?(previous_color)
    end

    # prints the board using Printables module
    def to_s
        print_chess_board
    end

    private

    def initial_pawn_row(color, rank)
        8.times do |index|
            @data[rank][index] = Pawn.new(self, { color: color, location: [rank, index] })
        end
    end

    def initial_row(color, rank)
        @data[rank] = [
            Rook.new(self, { color: color, location: [rank, 0] }),
            Knight.new(self, { color: color, location: [rank, 1] }),
            Bishop.new(self, { color: color, location: [rank, 2] }),
            Queen.new(self, { color: color, location: [rank, 3] }),
            King.new(self, { color: color, location: [rank, 4] }),
            Bishop.new(self, { color: color, location: [rank, 5] }),
            Knight.new(self, { color: color, location: [rank, 6] }),
            Rook.new(self, { color: color, location: [rank, 7] })
        ]
    end # close initial_row

    def update_all_moves_captures
        pieces = @data.flatten(1).compact
        pieces.each { |piece| piece.update(self) }
    end

    def en_passant_capture?(coordinates)
        @previous_piece&.location == [coordinates[:row], coordinates[:column]] && en_passant_pawn?
    end

    def en_passant_pawn?
        two_pawns? && @active_piece.en_passant_rank? && @previous_piece.en_passant
    end
    
    # checks if the previous piece moved was a pawn and current piece being moved is also a pawn
    def two_pawns?
        @previous_piece.symbol == " \u265F " && @active_piece.symbol == " \u265F " 
    end

    def pawn_promotion?(coordinates)
        @active_piece.symbol == " \u265F " && promotion_rank?(coordinates[:row])
    end

    def promotion_rank?(rank)
        color = @active_piece.color
        (color == :white && rank.zero?) || (color == :black && rank == 7)
    end

    def castling?(coordinates)
        file_difference = (coordinates[:column] - @active_piece.location[1]).abs
        @active_piece&.symbol == " \u265A " && file_difference == 2
    end

    def castling_moves?
        location = @active_piece.location
        rank = location[0]
        file = location[1]
        king_side = [rank, file + 2]
        queen_side = [rank, file - 2]
        @active_piece&.moves&.include?(king_side) || @active_piece&.moves&.include?(queen_side)
    end

    def no_legal_moves_captures?(color)
        pieces = @data.flatten(1).compact
        pieces.none? do |piece|
            next unless piece.color == color
            piece.moves.size.positive? || piece.captures.size.positive?
        end
    end
end