# frozen_string_literal: true

module GamePrompts
    # def menu_option
    #     @prompt = TTY::Prompt.new
    #     @user_input = @prompt.select("Play game option: ", ["\e[1mSingle Player\e[0m", "\e[1mTwo Player\e[0m", "\e[1mLoad Game\e[0m", "\e[1mHow to Play\e[0m", "\e[1mQuit\e[0m"])
    #     puts "This is the users selection: #{@user_input}"
    # end

    def select_game_mode
        user_mode_select = gets.strip
        return user_mode_select if user_mode_select.match?(/^[12345]$/)   # will only return if input matches defined numbers in []
        
        puts "Input error! Please select from one of the menu options: 1, 2, 3, 4 or 5."
        select_game_mode
    end
    
    def repeat_game
        puts repeat_game_choices
        input = gets.strip
        choice = input.upcase == 'Q' ? exit_program : :repeat
        return choice if input.match?(/^[QP]$/i)

        puts "Input error! Please enter Q or P."
        repeat_game
    end


    def game_mode_choices
        <<~HEREDOC

        \e[45mWelcome to CLI Chess!\e[0m

        To START, enter one of the following to play:

            \e[96m(1)\e[0m to play a \e[93mNew 1-Player\e[0m game against the computer
            \e[96m(2)\e[0m to play a \e[93mNew 2-Player\e[0m game
            \e[96m(3)\e[0m to play a \e[93mSaved\e[0m game
            \e[96m(4)\e[0m to view \e[93mHow To Play\e[0m
            \e[96m(5)\e[0m to \e[93mExit Program\e[0m

        HEREDOC
    end

    # \e[45mStep 1:\e[0m
    # Select the coordinates of the piece that you want to move.

    # \e[45mStep 2:\e[0m
    # Enter coordinates of a legal move highlighted in \e[102m  \e[0m or capture \e[101m \u265F \e[0m.

    def how_to_play
        system 'clear'
        puts "HOW TO PLAY \n\n".colorize(:yellow)
        puts "Player's turn will comprise of 2 steps. \n".colorize(:cyan)
        puts "STEP 1: ".colorize(:magenta) + "Select the coordinates of piece you wish to move. eg. d2 \n".colorize(:cyan)
        puts "STEP 2: ".colorize(:magenta) + "Enter coordinates of valid move (highlighted in green) or capture (red). eg. d4 \n\n".colorize(:cyan)
         "To go back to the Main Menu, press \e[4mM\e[0m"

        sleep(5)

    end

    def repeat_game_choices
        <<~HEREDOC
        
            Would you like to start a New Game or Quit Game?
            \e[96m[P]\e[0m to Play A New Game or \e[91m[Q]\e[0m to Quit
            
        HEREDOC
    end

    def game_end_message
        return unless @player_count.positive?

        if @board.king_in_check?(@current_turn)
            puts "\e[106mCHECKMATE! #{previous_color.upcase} WINS!!\e[0m"
        else
            puts "\e[106mSTALEMATE! Game is a draw."
        end
    end

    def user_piece_selection
        <<~HEREDOC

        Please enter the coordinates of the piece you wish to move.

        HEREDOC
    end

    def user_move_selection
        <<~HEREDOC

        Please enter coordinates for a legal move, square(s) highlighted \e[102m   \e[0m or capture \e[101m \u265F \e[0m. 

        HEREDOC
    end

    def en_passant_warning
        <<~HEREDOC
            You have the option to capture the opposing pawn that just moved. To capture this pawn en passant (in passing), please enter the \e[41m highlighted coordinates\e[0m.

            As part of en passant,\e[36m your pawn will be moved to the square in front of the captured pawn\e[0m.

        HEREDOC
    end

    def king_check_warning
        puts "\e[91mWARNING!\e[0m Your King is currently in check!"
    end

    def castling_warning
        <<~HEREDOC
            You have the option to castle, where the King will move 2 spaces and will castle with the rook.

            As part of castling,\e[96m your rook will be moved to the square that the king passes through\e[0m.

        HEREDOC
    end

    def previous_color
        @current_turn == :white ? 'Black' : 'White'
    end

    def resign_game
        puts "#{@current_turn.upcase} RESIGNS! #{previous_color.upcase} WINS!!!".colorize(:green)
        @player_count = 0     # since player count is less than 1, ends game
    end

    def exit_program
        sleep(1)
        system 'clear'
        puts "Thank you for playing CLI Chess!"
        sleep(2)
        exit
    end
end