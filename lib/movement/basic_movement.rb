# frozen_string_literal: true

# logic for basic moves for all pieces
# when a piece moves, have to update it's location at the new coordinates and also remove the piece from the original location.
# when a piece is capture, must remove (delete) it as an observer.
# also need to update active piece location to indicate last move.
class BasicMovement
    attr_reader :row, :column, :board

    def initialize(board = nil, row = nil, column = nil)
        @board = board
        @row = row
        @column = column
    end

    def update_pieces(board, coordinates)
        @board = board
        @row = coordiantes[:row]
        @column = coordinates[:column]
        update_basic_moves
    end

    def update_basic_moves
        remove_capture_piece_observer if @board.data[row][column]
        update_new_coordinates
        remove_original_piece
        update_active_piece_location
    end
    
    def remove_capture_piece_observer
        @board.delete_observer(@board.data[row][column])
    end

    def update_new_coordinates
        @board.data[row][column] = @board.active_piece
    end

    def remove_original_piece
        location = @board.active_piece.location
        @board.data[location[0]][location[1]] = nil
    end

    def update_active_piece_location
        @board.active_piece.update_location(row, column)
    end
end
