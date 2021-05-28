
module GamePrompts
    # def menu_option
    #     @prompt = TTY::Prompt.new
    #     @user_input = @prompt.select("Play game option: ", ["\e[1mSingle Player\e[0m", "\e[1mTwo Player\e[0m", "\e[1mLoad Game\e[0m", "\e[1mHow to Play\e[0m", "\e[1mQuit\e[0m"])
    #     puts "This is the users selection: #{@user_input}"
    # end

    def select_game_mode
        user_mode_select = gets.strip
        return user_mode_select if user_mode_select.match?(/^[1234]$/)   # will only return if input matches defined numbers in []
        
        puts "Input error! Please enter 1, 2, 3 or 4."
        select_game_mode
    end
    
    def repeat_game
        puts repeat_game_choices
        input = gets.strip
        choice = input.upcase == 'Q' ? :quit : :repeat
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

        HEREDOC
    end

    def game_instructions
        <<~HEREDOC

        Each turn will have two steps:

        \e[45mStep 1:\e[0m
        Enter the coordinates of the piece that you want to move.

        \e[45mStep 2:\e[0m
        Enter the coordinates of a legal move \e[102m  \e[0m or capture \e[101m \u265F \e[0m.

        HEREDOC
    end

    def repeat_game_choices
        <<~HEREDOC
        
            Would you like to quit game or play again?
            \e[91m[Q]\e[0m to Quit or \e[96m[P]\e[0m to Play Again
            
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

        Please enter coordinates for a legal move highlighted \e[102m   \e[0m or capture \e[101m \u265F \e[0m. 

        HEREDOC
    end

end