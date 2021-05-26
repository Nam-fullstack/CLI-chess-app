require 'tty-prompt'
require_relative 'board'

@prompt = TTY::Prompt.new

# puts " ____"
# puts "|    |"
# puts "|    |" 
# puts " \u203E\u203E\u203E\u203E" prints overscore

def menu_option
    user_input = @prompt.select("Play game option: ", ["Single Player", "Two Player", "Load Game", "Quit"])
end