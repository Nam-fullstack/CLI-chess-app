# frozen_string_literal: true

require_relative '../board'
require_relative '../move_validator'

# base logic for all chess pieces
class Piece
  attr_reader :color, :location, :moves, :moved, :captures, :symbol

  def initialize(board, attributes)
    @color = attributes[:color]
    @location = attributes[:location]
    @captures = []
    @moves = []
    @moved = false
    @symbol = nil
    board.add_observer(self)
  end

  def update_location(row, column)
    @location = [row, column]
    @moved = true
  end

  def update(board)
    current_captures(board)
    current_moves(board)
  end

  def current_moves(board)
    possible_moves = find_possible_moves(board)
    @moves = remove_illegal_moves(board, possible_moves)
  end

  def current_captures(board)
    possible_captures = find_possible_captures(board)
    @captures = remove_illegal_moves(board, possible_captures)
  end

  def find_possible_moves(board)
    moves = move_mechanics.inject([]) do |memo, move|
      memo << create_moves(board.data, move[0], move[1])
    end
    moves.compact.flatten(1)
  end

  def find_possible_captures(board)
    captures = move_mechanics.inject([]) do |memo, move|
      memo << create_captures(board.data, move[0], move[1])
    end
    captures.compact
  end

  def remove_illegal_moves(board, moves)
    return moves unless moves.size.positive?

    temp_board = Marshal.load(Marshal.dump(board))
    validator = MoveValidator.new(location, temp_board, moves)
    validator.verify_possible_moves
  end

  private

  # adds moves until it reaches a piece or still within the board,
  # based on each piece's move mechanics
  def create_moves(data, rank_change, file_change)
    rank = @location[0] + rank_change
    file = @location[1] + file_change
    result = []
    while valid_location?(rank, file)
      break if data[rank][file]

      result << [rank, file]
      rank += rank_change
      file += file_change
    end
    result
  end

  # adds capture if piece's move set reaches opponent's piece,
  # dependent on the piece's move mechanics.
  def create_captures(data, rank_change, file_change)
    rank = @location[0] + rank_change
    file = @location[1] + file_change
    while valid_location?(rank, file)
      break if data[rank][file]

      rank += rank_change
      file += file_change
    end
    [rank, file] if opposing_piece?(rank, file, data)
  end

  # ensures pieces don't go outside the board, only locations inside board are valid.
  def valid_location?(rank, file)
    rank.between?(0, 7) && file.between?(0, 7)
  end

  # checks if piece is opposing/not the same color
  def opposing_piece?(rank, file, data)
    return unless valid_location?(rank, file)

    piece = data[rank][file]
    piece && piece.color != color
  end
end
