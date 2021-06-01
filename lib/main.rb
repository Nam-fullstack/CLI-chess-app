# frozen_string_literal: true

require 'tty-prompt'
require 'tty-progressbar'

require_relative 'board'
require_relative 'printables'
require_relative 'game'
require_relative 'game_prompts'
require_relative 'notation_converter'
require_relative 'move_validator'
require_relative 'serializer'
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

# extend GamePrompts
# extend Serializer

def play_game(input)
    case input
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
end

loop do
    select_game_mode
    play_game(@mode)
    break if @mode == 5
end
