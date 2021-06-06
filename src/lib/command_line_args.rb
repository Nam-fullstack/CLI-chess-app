# frozen_string_literal: true

if ARGV.length > 0
  flag, *rest = ARGV
  ARGV.clear
  case flag
  when '--help', '-help', '-h'
    puts "To run this program, please \e[91mcd..\e[0m \e[93mto the /src\e[0m directory and run the following command:"
    puts "\e[96m./run_chess.sh\e[0m\n"
    puts 'If there are problems running this script, then an alternative to load the application'
    puts "Is to run: \n\e[92mruby lib/main.rb\e[0m \n\n"
    puts 'For further information, please see documentation in README.md or go to'
    puts 'https://github.com/Nam-fullstack/terminal-chess to view the detailed installation instructions'
    puts 'outlined in README.md. '
  when '--info', '-info', '-i'
    puts "This machine is running Ruby version: #{RUBY_VERSION}"
    puts "Please run 'ruby lib/main.rb -r' to view necessary requirements and installation of Gem dependencies"
    puts "required to correct run the application."
  when '--list', '-list', '-l'
    puts 'Here are the list of the possible commands you can perform:'
    puts "\e[91m-h          help:\e[0m instructions on how to run the program and link to view README on GitHub."
    puts "\e[91m-i          info:\e[0m tell you what version of Ruby is running on your computer."
    puts "\e[91m-l          list:\e[0m lists all the possible flag arguments."
    puts "\e[91m-load       load:\e[0m details on how the load game functionality works in the game."
    puts "\e[91m-p          path:\e[0m what file directory you need to be in for everything to run correctly."
    puts "\e[91m-r          requirements:\e[0m details of specifications needed to run application."
    puts "\e[91m-s          save:\e[0m details on how the save game functionality works in the game."
  when '--load', '-load'
    puts "This feature of the game allows you to load a previously saved game."
    puts "and resume where you left off. To \e[96m'Load'\e[0m a saved game, simply select"
    puts "the \e[96mfile #\e[0m by typing in the corresponding \e[96mnumber\e[0m of the game you" 
    puts "wish to load."
  when '--path', '-path', '-p'
    puts "cd to \e[91m/src\e[0m directory to ensure correct operation."
  when '--requirements', '-requirements', '-req', '-r'
    puts 'Recommended to have Ruby v 2.7.1+'
    puts 'Must have RubyGems and Bundler installed on machine'
    puts "If you don't have these installed, please download RubyGems on your computer"
    puts "And run 'gem install bundler' to install the bundler gem."
    puts "Once bundler is installed, please run 'bundle install' to install all the required dependencies in order for the application to work properly."
  when '--save', '-save', '-s'
    puts "This feature of the game allows you to \e[91msave\e[0m the current game's progress."
    puts "It will automatically save the game as '\e[93mChess YYYY-MM-DD at HH:MM:SS\e[0m' format."
  else
    puts "\e[91mInvalid argument.\e[0m"
    puts "For help, please type '\e[91mruby main.rb -help\e[0m' or '\e[91mruby main.rb -h\e[0m'"
    puts "For information, please type '\e[91mruby main.rb -info\e[0m' or '\e[91mruby main.rb -i\e[0m'"
  end
  exit
end
