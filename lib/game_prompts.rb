


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
    
end