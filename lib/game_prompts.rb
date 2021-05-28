


module GamePrompts
    def select_game_mode
        user_mode_select = gets.strip
        return user_mode_select if user_mode_select.match?(/^[123]$/)   # will only return if input matches defined numbers in []
        
        puts "Input error! Please enter 1, 2, or 3."
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

        Each turn will have two steps:

        \e[45mStep 1:\e[0m
        Enter the coordinates of the piece that you want to move.

        \e[45mStep 2:\e[0m
        Enter the coordinates of any legal move \e[102m  \e[0m or capture \e[101m \u265F \e[0m.

        To START, enter one of the following to play:

            \e[96m(1)\e[0m to play a \e[93mNew 1-Player\e[0m game against the computer
            \e[96m(2)\e[0m to play a \e[93mNew 2-Player\e[0m game
            \e[96m(3)\e[0m to play a \e[93mSaved\e[0m game

        HEREDOC
    end

    def repeat_game_choices
        <<~HEREDOC
        
            Would you like to quit game or play again?
            \e[91m[Q]\e[0m to Quit or \e[96m[P]\e[0m to Play Again
            
        HEREDOC
    end

end