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

# puts " ____"
# puts "|    |"
# puts "|    |" 
# puts " \u203E\u203E\u203E\u203E" prints overscore

def menu_option
    user_input = @prompt.select("Play game option: ", ["Single Player", "Two Player", "Load Game", "Quit"])
end