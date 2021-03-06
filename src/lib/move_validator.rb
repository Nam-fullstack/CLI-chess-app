# frozen_string_literal: true

# removes any moves or captures that would put King in check
class MoveValidator
  def initialize(location, board, moves, piece = board.data[location[0]][location[1]])
    @current_locoation = location
    @board = board
    @move_list = moves
    @current_piece = piece
    @king_location = nil
  end

  def verify_possible_moves
    @king_location = find_king_location
    @board.data[@current_locoation[0]][@current_locoation[1]] = nil
    @move_list.select do |move|
      legal_move?(move)
    end
  end

  private

  # moves board/pieces around to the possible move and checks if the King is safe
  def legal_move?(move)
    captured_piece = @board.data[move[0]][move[1]]
    move_current_piece(move)
    king = @king_location || move
    result = safe_king?(king)
    @board.data[move[0]][move[1]] = captured_piece
    result
  end

  def move_current_piece(move)
    @board.data[move[0]][move[1]] = @current_piece
    @current_piece.update_location(move[0], move[1])
  end

  # determines if the King is safe (not under check, returns false).
  # If King's location matches any possible captures for any of opponent's pieces.
  def safe_king?(kings_location)
    pieces = @board.data.flatten(1).compact
    pieces.none? do |piece|
      next unless piece.color != @current_piece.color

      captures = piece.find_possible_captures(@board)
      captures.include?(kings_location)
    end
  end

  # finds location of King to determine if selected piece can move or not based on
  # King's location and if King will be safe based on the user's desired move,
  # if it's not, will cause MoveError message alert
  def find_king_location
    return if @current_piece.symbol == " \u265A "

    if @current_piece.color == :black
      @board.black_king.location
    else
      @board.white_king.location
    end
  end
end
