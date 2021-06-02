# frozen_string_literal: true

if ARGV.length > 0
  flag, *rest = ARGV
  ARGV.clear
  case flag
  when '--help', '-help', '-h'
    puts "To run this program, please \e[91mcd..\e[0m \e[93mto the /src\e[0m directory and run the following command:"
    puts "\e[96m./run_chess.sh\e[0m\n"
    puts 'See further documentation in readme.md'
    exit
  when '--info', '-info', '-i'
    puts "This program is using Ruby version: #{RUBY_VERSION}"

  when '--load', '-load', '-l'
    puts "This feature of the game allows you to load a previously saved game"
    puts "and resume where you left off. To \e[96m'Load'\e[0m a saved game, simply select"
    puts "the \e[96mfile #\e[0m by typing in the corresponding \e[96mnumber\e[0m of the"
    puts "game you wish to load."
    exit
  when '--path', '-path', '-p'
    
    exit
  when '--save', '-save', '-s'
    puts "This feature of the game allows you to \e[91msave\e[0m the current game's progress."
    puts "It will automatically save the game as '\e[93mChess YYYY-MM-DD at HH:MM:SS\e[0m' format."
    exit
  else
    puts "\e[91mInvalid argument.\e[0m"
    puts "For help, please type 'ruby main.rb -help' or ' ruby main.rb -h'"
    exit
  end
end
