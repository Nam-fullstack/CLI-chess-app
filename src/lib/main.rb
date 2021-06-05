# frozen_string_literal: true

require_relative 'command_line_args'
require_relative 'landing_banner'
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
require_relative 'movement/pawn_promotion_movement'

extend GamePrompts
extend Serializer

def play_game(selection)
  case selection
  when 1
    start_game(1)
  when 2
    start_game(2)
  when 3
    load_game.play
  when 4
    how_to_play
  when 5
    exit_program
  end
end

def start_game(players)
  loading(0.1, 5)
  player = Game.new(players)
  player.setup_board
  player.play
end

def main_menu
  select_game_mode
  play_game(@mode)
end

loading(2, 50)
# display_ansi

loop do
    main_menu
rescue StandardError, NoMemoryError, ScriptError, SecurityError, SystemStackError => e
    puts e.message
end
