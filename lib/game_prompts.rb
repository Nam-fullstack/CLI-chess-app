# frozen_string_literal: true

require 'colorize'
require 'tty-prompt'
require 'tty-progressbar'

# contains text prompts for chess game
module GamePrompts
  def loading(time, loads)
    puts "\n\n"
    bar = TTY::ProgressBar.new("LOADING [:bar] :percent", bar_format: :tread, total: loads, width: 70)
    loads.times do
      sleep(0.045)
      bar.advance
    end
    pausing(time)
  end

  def select_game_mode
    puts "\n\n"
    prompt = TTY::Prompt.new
    options = {
      "Single Player" => 1,
      "Two Player" => 2,
      "Load Game" => 3,
      "How to Play" => 4,
      "Exit" => 5
    }
    @mode = prompt.select('MAIN MENU', options, convert: :integer)
  end

  def return_to_menu
    prompt = TTY::Prompt.new
    choice = prompt.select('Do you want to go back to the Main Menu?', ['Yes', 'Quit'])
    if choice == 'Yes'
      main_menu
    else
      exit_program
    end
  end

  def resign_game
    prompt = TTY::Prompt.new
    resign = prompt.select('Are you sure you want to resign?', 'Yes', 'No')
    if resign == 'Yes'
      puts "#{@current_turn.upcase} RESIGNS! #{previous_color.upcase} WINS!!! \n\n".colorize(:green)
      pausing(2.4)
    #   @player_count = 0 # when player count is less than 1, ends game
      play_again
    else
      play
    end
  end

  def play_again
    prompt = TTY::Prompt.new
    again = prompt.select('Do you wish to play again?', 'Yes', 'No')
    if again == 'Yes'
      main_menu
    elsif again == 'No'
      exit_program
    end
  end

  def exit_program
    prompt = TTY::Prompt.new
    puts
    final_choice = prompt.select('Are you sure you want to Exit?', 'Yes', 'No')
    if final_choice == 'Yes'
      pausing(0.5)
      quit_app
    else
      main_menu
    end  
  end

  def quit_app
    system 'clear'
    puts "Thank you for playing CLI Chess! \nHope you enjoyed this game!"
    sleep(1)
    exit
  end

  def pausing(time)
    sleep(time)
    system 'clear'
  end

  private

  def how_to_play
    system 'clear'
    puts "HOW TO PLAY \n".colorize(:yellow)
    puts "Each player's turn will comprise of 2 steps. \n".colorize(:cyan)
    puts 'STEP 1: '.colorize(:magenta) + 'Select the coordinates of piece you wish to move.' + " eg. d2 \n".colorize(:cyan)
    puts 'STEP 2: '.colorize(:magenta) + "Enter coordinates of\e[92m valid move\e[0m:"
    puts "        square(s) highlighted \e[102m   \e[0m or capture \e[101m \u265F \e[0m\n\n"
    puts "For more information on how to play chess, please view \e[94mHow To Play Chess.pdf\e[0m file.\n\n"
    puts "During a Game, you can do the following actions:\n"
    puts "To \e[91mSave\e[0m current game, enter '\e[91mS\e[0m'."
    puts "To \e[91mLoad\e[0m a game, enter '\e[91mL\e[0m'."
    puts "To start a \e[94mNew Game\e[0m, enter '\e[91mN\e[0m'."
    puts "To \e[91mQuit\e[0m a game, enter '\e[91mQ\e[0m'.\n\n"
    sleep(5)
    return_to_menu
  end

  def game_end_message
    return unless @player_count.positive?

    if @board.king_in_check?(@current_turn)
      puts "\nCHECKMATE! #{previous_color.upcase} WINS!!\n\n".colorize(:green)
    else
      puts "\nSTALEMATE! Game is a draw.\n\n".colorize(:cyan)
    end
    play
  end

  def user_piece_selection
    <<~HEREDOC

      Please enter the \e[94mcoordinates\e[0m of the piece you wish to move.

    HEREDOC
  end

  def user_move_selection
    <<~HEREDOC

      Please enter coordinates for a legal move:
      square(s) highlighted \e[102m   \e[0m or capture \e[101m \u265F \e[0m.

    HEREDOC
  end

  def en_passant_warning
    puts "\e[96mOption to capture the opposing pawn that just moved.\e[0m"
    puts "\n\e[91mTo capture this pawn en passant\e[0m (in passing),"
    puts "please enter the \e[41mhighlighted coordinates\e[0m."
    puts "As part of en passant, your\e[96m pawn will be moved"
    puts "to the square in front of the captured pawn\e[0m."
  end

  def king_check_warning
    puts "\n\e[91mWARNING!\e[0m Your \u2654 King is currently in \e[91mcheck!\e[0m"
  end

  def castling_warning
    puts "\e[96mYou have the option to castle: \e[0m \n\n\e[95mYour King \u2654 will move 2 spaces\e[0m \nand will castle with the rook."
    puts "Your\e[96m Rook \u2656 will be moved\e[0m to the \nsquare that the king passes through."
  end

  def previous_color
    @current_turn == :white ? 'Black' : 'White'
  end
end
