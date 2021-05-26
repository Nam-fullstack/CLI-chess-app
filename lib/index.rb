require 'tty-prompt'
require_relative 'board'
require_relative 'printables'
require_relative 'pieces/piece'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/pawn'

@prompt = TTY::Prompt.new



def menu_option
    user_input = @prompt.select("Play game option: ", ["Single Player", "Two Player", "Load Game", "Quit"])
end

def play_game(input)
    if input == '1'
        single_player = Game.new(1)
        single_player.setup_board
        single_player.play_game
    elsif input == '2'
        two_payer = Game.new(2)
        two_payer.setup_board
        two_payer.play
    elsif input == '3'
        load_game.play
    end
end

module GamePrompts
    def select_game_mode
        user_mode_select = gets.strip
        return user_mode_select if user_mode_select.match?(/^[123]$/)   # will only return if input matches defined numbers in []
        puts "Input error! Please enter 1, 2, or 3."
        select_game_mode
    end

end


loop do
    puts game_mode_choices
    mode = select_game_mode
    play_game(mode)
    break if repeat_game == :Quit
end