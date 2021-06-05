# frozen_string_literal: true

require_relative 'basic_movement'

# logic for en passant capture
class EnPassantMovement < BasicMovement
  def intialize(board = nil, row = nil, column = nil)
    super
  end

  def update_pieces(board, coordinates)
    @board = board
    @row = coordinates[:row]
    @column = coordinates[:column]
    update_en_passant_moves
  end

  def update_en_passant_moves
    remove_capture_piece_observer
    update_active_pawn_coordinates
    remove_original_piece
    remove_en_passant_capture
    update_active_piece_location
  end

  def update_active_pawn_coordinates
    @board.data[new_rank][column] = @board.active_piece
  end

  def remove_en_passant_capture
    @board.data[row][column] = nil
  end

  def update_active_piece_location
    @board.active_piece.update_location(new_rank, column)
  end

  # this determines new rank of the pawn based on its rank direction (black or white)
  def new_rank
    row + @board.active_piece.rank_direction
  end
end
