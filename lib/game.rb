

require_relative 'game_prompts'


class Game
    # declares an error message when user enters an invalid input
    class InputError < StandardError
        def message
            "Invalid input! Please enter file and rank. eg: d2"
        end
    end

    # declares an error message when user enters coordinates of opponent's piece
    class CoordinatesError < StandardError
        def message
            "Invalid coordinates! Please enter file and rank of the correct color."
        end
    end

    # declares an error message when user enters invalid coordinates for move
    class MoveError < StandardError
        def message
            "Invalid coordinates! Please enter a valid file and rank to move."
        end
    end

    # declares an error message when user selects a piece with no legal moves
    class PieceError < StandardError
        def message
            "Invalid piece! There are no legal moves for this piece."
        end
    end

    include GamePrompts

    def initialize(number, board = Board.new, current_turn = :white)
        @player_count = number
        @board = board
        @current_turn = current_turn
    end

    def setup_board
        @board.update_mode if @player_count == 1
        @board.initial_positioning
    end

    def play
        @board.to_s
        player_turn until @board.game_over? || @player_count.zero?
        exit_message
    end

    def player_turn
        if @player_count == 1 && @current_turn == :black
            puts "Black to move:".upcase
            computer_player_turn
        else
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

        coordinates = translate_notation(input)
        validate_piece_coordinates(coordinates)
        @board.update_active_piece(coordinates)
        validate_active_piece
    rescue StandardError => each
        puts e.message
        retry
    end

    def select_move_coordinates
        input = user_select_move
        coordinates = translate_notation(input)
        validate_move(coordinates)
        coordinates
    rescue StandardError => each
        puts e.message
        retry
    end

    def user_select_piece
        
        input = user_input(user_piece_selection)
        validate_piece_input(input)
        resign_game if input.upcase == "Q"
        save_game if input.upcase == "S"
        input
    end

    def user_select_move
        
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

    # need to double check if this works with RSPEC!! 
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

    def translate_notation(input)
        translator ||= NotationConverter.new
        translator.translate_notation(input)
    end

    private

    def user_input(prompt)
        puts prompt
        gets.strip
    end
end