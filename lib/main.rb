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
require_relative 'movement/movement_factory'
require_relative 'movement/basic_movement'
require_relative 'movement/en_passant_movement'
require_relative 'movement/castling_movement'
require_relative 'movement/promotion_movement'

extend GamePrompts

def play_game(input)
    case(input.to_i)
    when 1
        single_player = Game.new(1)
        single_player.setup_board
        single_player.play
    when 2
        two_payer = Game.new(2)
        two_payer.setup_board
        two_payer.play
    when 3
        load_game.play
    when 4
        how_to_play
    when 5
        exit_program
    end


    # if input == "1"
    # # if input == "\e[1mSingle Player\e[0m"
    #     single_player = Game.new(1)
    #     single_player.setup_board
    #     single_player.play
    # elsif input == "2"
    # # elsif input == "\e[1mTwo Player\e[0m"
    #     two_payer = Game.new(2)
    #     two_payer.setup_board
    #     two_payer.play
    # elsif input == "3"
    # # elsif input == "\e[1mLoad Game\e[0m"
    #     load_game.play
    # elsif input == "4"
    #     how_to_play
    # elsif input == "5"
    #     exit
    # end
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