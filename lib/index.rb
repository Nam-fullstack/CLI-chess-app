# frozen_string_literal: true

require 'tty-prompt'

require_relative 'board'
require_relative 'printables'
require_relative 'game'
require_relative 'game_prompts'
require_relative 'notation_converter'
require_relative 'move_validator'
require_relative 'pieces/piece'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/pawn'

extend GamePrompts

def play_game(input)
    if input == "1"
    # if input == "\e[1mSingle Player\e[0m"
        single_player = Game.new(1)
        single_player.setup_board
        single_player.play
    elsif input == "2"
    # elsif input == "\e[1mTwo Player\e[0m"
        two_payer = Game.new(2)
        two_payer.setup_board
        two_payer.play
    elsif input == "3"
    # elsif input == "\e[1mLoad Game\e[0m"
        load_game.play
    elsif input == "4"
        game_instructions
    end
end

# loop do
#     menu_option
#     play_game(@user_input)
# end

loop do
    puts game_mode_choices
    mode = select_game_mode
    play_game(mode)
    break if repeat_game == :Quit
end