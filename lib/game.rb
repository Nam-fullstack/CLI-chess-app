# frozen_string_literal: true

require_relative 'game_prompts'
# require_relative 'board'
# require_relative 'notation_converter'


class Game
    # declares an error message when user enters an invalid input
    class InputError < StandardError
        def message
            "Invalid input error! Please enter a piece's file and rank. eg: d2"
        end
    end

    # declares an error message when user enters coordinates of opponent's piece
    class CoordinatesError < StandardError
        def message
            "Invalid coordinates error! Please enter file and rank of a piece that is your color."
        end
    end

    # declares an error message when user enters invalid coordinates for move
    class MoveError < StandardError
        def message
            "Invalid move error! Please enter file and rank of a valid move for this piece: square(s) highlighted in \e[102m   \e[0m "
        end
    end

    # declares an error message when user selects a piece with no legal moves
    class PieceError < StandardError
        def message
            "No moves error! There are no legal moves for this piece and/or King is under check."
        end
    end

    include GamePrompts
# 

    def initialize(number, board = Board.new, current_turn = :white)
        @player_count = number
        @board = board
        @current_turn = current_turn
    end

    def setup_board
        @board.update_mode if @player_count == 1
        @board.initial_placement
    end

    def play
        @board.to_s
        player_turn until @board.game_over? || @player_count.zero?
        game_end_message
    end

    def player_turn
        if @player_count == 1 && @current_turn == :black    
            puts "Black to move:".upcase
            computer_player_turn
        elsif @player_count == 2 && @current_turn == :black    
            puts "Black to move:".upcase
            human_player_turn
        else
            puts "White to move:".upcase
            human_player_turn
        end
        return unless @player_count.positive?
        @board.to_s
        switch_color
    end

    def human_player_turn
        select_piece_coordinates
        return unless @player_count.positive?
        @board.to_s
        move = select_move_coordinates
        @board.update(move)
    end

    def computer_player_turn
        sleep(1.5)
        coordinates = computer_select_random_piece
        @board.update_active_piece(coordinates)
        @board.to_s
        sleep(1.5)
        move = computer_select_random_move
        @board.update(move)
    end

    def select_piece_coordinates
        input = user_select_piece
        return unless @player_count.positive?
        coordinates = translate_coordinates(input)
        validate_piece_coordinates(coordinates)
        @board.update_active_piece(coordinates)
        validate_active_piece
    rescue StandardError => e
        puts e.message
        retry
    end

    def select_move_coordinates
        input = user_select_move
        coordinates = translate_coordinates(input)
        validate_move(coordinates)
        coordinates
    rescue StandardError => e
        puts e.message
        retry
    end

    def user_select_piece
        puts king_check_warning if @board.king_in_check?(@current_turn)
        input = user_input(user_piece_selection)
        validate_piece_input(input)
        resign_game if input.upcase == "Q"
        save_game if input.upcase == "S"
        input
    end

    def user_select_move
        puts en_passant_warning if @board.possible_en_passant?
        puts castling_warning if @board.possible_castling?
        input = user_input(user_move_selection)
        validate_move_input(input)
        resign_game if input.upcase == "Q"
        input
    end

    def switch_color
        @current_turn = @current_turn == :white ? :black : :white
    end 

    def computer_select_random_piece
        @board.random_black_piece
    end
    
    def computer_select_random_move
        @board.random_black_move
    end

    def validate_piece_input(input)
        raise InputError unless input.match?(/^[a-h][1-8]$|^[q]$|^[s]$/i)
    end

    def validate_move_input(input)
        raise InputError unless input.match?(/^[a-h][1-8]$/i)
    end

    def validate_piece_coordinates(coordinates)
        raise CoordinatesError unless @board.valid_piece?(coordinates, @current_turn)
    end

    def validate_move(coordinates)
        raise MoveError unless @board.valid_piece_movement?(coordinates)
    end

    def validate_active_piece
        raise PieceError unless @board.active_piece_moveable?
    end

    # translator translates chess notation into hash of coordinates
    def translate_coordinates(input)
        translator ||= NotationConverter.new
        translator.translate_notation(input)
    end

    private

    def user_input(prompt)
        puts prompt
        gets.strip
    end
end