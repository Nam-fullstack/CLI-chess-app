# frozen_string_literal: true

require_relative 'basic_movement'

# logic for castling movement
class CastlingMovement < BasicMovement
  def initialize(board = nil, row = nil, column = nil)
    super
  end

  def update_pieces(board, coordinates)
    @board = board
    @row = coordinates[:row]
    @column = coordinates[:column]
    update_castling_moves
  end

  # main logic for castling
  def update_castling_moves
    update_new_coordinates
    remove_original_piece
    update_active_piece_location
    castling_rook = find_castling_rook
    remove_original_rook_piece
    update_castling_coordinates(castling_rook)
    update_castling_piece_location(castling_rook)
  end

  def find_castling_rook
    @board.data[row][old_rook_file]
  end

  def remove_original_rook_piece
    @board.data[row][old_rook_file] = nil
  end

  def update_castling_coordinates(rook)
    @board.data[row][new_rook_file] = rook
  end

  def update_castling_piece_location(rook)
    rook.update_location(row, new_rook_file)
  end

  private

  # determines the original rook location based on the file (column) of the King's move
  def old_rook_file
    king_side = 7
    queen_side = 0
    column == 6 ? king_side : queen_side
  end

  # determines the rook's new location based on the file (column) of the King's move
  def new_rook_file
    king_side = 5
    queen_side = 3
    column == 6 ? king_side : queen_side
  end
end
