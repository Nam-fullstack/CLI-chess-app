# frozen_string_literal: true

require_relative 'piece'

# move mechanics for pawn
class Pawn < Piece
  attr_reader :en_passant

  def initialize(board, attributes)
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
    (rank == 4 && color == :black) || (rank == 3 && color == :white)
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

  # determines if pawn has moved or not, if it has, then disables double advance from pawn's possible move mechanics
  def invalid_bonus_move?(board, bonus)
    first_move = single_advance(board)
    return true unless first_move

    @moved || board.data[bonus[0]][bonus[1]]
  end

  # defines capture mechanics for pawns, can only capture on diagonal in direction it goes
  def basic_capture(board, file)
    rank = @location[0] + rank_direction
    return [rank, file] if opposing_piece?(rank, file, board.data)
  end

  # defines en passant capture mechanics:
  # 1) has to be adjacent file, only when it is,
  # 2) determine if it's a valid en passant capture
  def en_passant_capture(board)
    capture = board.previous_piece&.location
    return unless capture

    column_difference = (@location[1] - capture[1]).abs
    return unless column_difference == 1

    return capture if valid_en_passant?(board)
  end

  # only enables en passant if the pawn has double advanced
  def update_en_passant(row)
    @en_passant = (row - location[0]).abs == 2
  end

  # NEED TO CHECK THIS, but think logic should be right, piece that moved previously has to be a pawn that has
  # done a double advance and consequently, have en passant as true. 
  # Capturing pawn has to be in the correct rank for color
  # AND also need to check if en passant move and capture will not leave the King in check (legal_en_passant).
  def valid_en_passant?(board)
    en_passant_rank? &&
      symbol == board.previous_piece.symbol &&
      board.previous_piece.en_passant &&
      legal_en_passant_move?(board)
  end

  # checks if en passant move will leave King in check
  def legal_en_passant_move?(board)
    pawn_location = board.previous_piece.location
    en_passant_move = [pawn_location[0], pawn_location[1] + rank_direction]
    temp_board = remove_captured_en_passant_pawn(board, pawn_location)
    legal_capture = remove_illegal_moves(temp_board, en_passant_move)
    legal_capture.size.positive?
  end

  def remove_captured_en_passant_pawn(board, pawn_location)
    temp_board = Marshal.load(Marshal.dump(board))
    temp_board.data[pawn_location[0]][pawn_location[1]] = nil
    temp_board
  end

  def move_mechanics; end
end
